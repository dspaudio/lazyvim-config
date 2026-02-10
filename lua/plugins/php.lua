return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "V13Axel/neotest-pest",
      "olimorris/neotest-phpunit",
    },
    opts = function(_, opts)
      local lib = require("neotest.lib")

      local function is_pest_file(file_path)
        if not file_path:match("Test%.php$") then
          return false
        end
        local f = io.open(file_path, "r")
        if not f then
          return false
        end
        local content = f:read("*a")
        f:close()
        local has_pest = content:match("%Wit%s*%(")
          or content:match("%Wtest%s*%(")
          or content:match("%Wdescribe%s*%(")
          or content:match("%Wuses%s*%(")
          or content:match("^it%s*%(")
          or content:match("^test%s*%(")
          or content:match("^describe%s*%(")
          or content:match("^uses%s*%(")
        return has_pest ~= nil
      end

      local function is_phpunit_file(file_path)
        if not file_path:match("Test%.php$") then
          return false
        end
        local f = io.open(file_path, "r")
        if not f then
          return false
        end
        local content = f:read("*a")
        f:close()
        local has_pest = content:match("%Wit%s*%(")
          or content:match("%Wdescribe%s*%(")
          or content:match("%Wuses%s*%(")
          or content:match("^it%s*%(")
          or content:match("^describe%s*%(")
          or content:match("^uses%s*%(")
        local has_phpunit = content:match("extends%s+TestCase") or content:match("namespace%s+Tests")
        return has_phpunit ~= nil and has_pest == nil
      end

      local pest_query = [[
        ((function_call_expression
            function: (name) @func_name (#match? @func_name "^(test|it)$")
            arguments: (arguments . (argument (_ (string_content) @test.name)))
        )) @test.definition
      ]]

      local phpunit_query = [[
        ((class_declaration
            name: (name) @namespace.name
        )) @namespace.definition

        ((method_declaration
            name: (name) @test.name (#match? @test.name "^test")
        )) @test.definition
      ]]

      local function pest_discover_positions(path)
        return lib.treesitter.parse_positions(path, pest_query, {
          nested_tests = false,
          require_namespaces = false,
        })
      end

      local function phpunit_discover_positions(path)
        return lib.treesitter.parse_positions(path, phpunit_query, {
          nested_tests = true,
          require_namespaces = true,
        })
      end

      local pest_adapter = require("neotest-pest")({
        pest_cmd = "vendor/bin/pest",
        root_files = { "tests/Pest.php", "phpunit.xml" },
      })
      pest_adapter.is_test_file = is_pest_file
      pest_adapter.discover_positions = pest_discover_positions

      local base_adapter = require("neotest-phpunit")
      local phpunit_adapter = base_adapter({
        phpunit_cmd = function()
          return vim.fn.getcwd() .. "/vendor/bin/phpunit"
        end,
        root_files = { "composer.json", "phpunit.xml" },
        env = {
          COLLISION_IGNORE_ERRORS = "true",
        },
        filter_dirs = { "vendor" },
      })
      
      local original_build_spec = phpunit_adapter.build_spec
      phpunit_adapter.build_spec = function(args)
        local spec = original_build_spec(args)
        local phpunit_path = vim.fn.getcwd() .. "/vendor/bin/phpunit"
        if spec.command[1] == phpunit_path then
          spec.command[1] = "php"
          table.insert(spec.command, 2, "artisan")
          table.insert(spec.command, 3, "test")
        end
        return spec
      end
      
      phpunit_adapter.is_test_file = is_phpunit_file
      phpunit_adapter.discover_positions = phpunit_discover_positions

      local original_results = phpunit_adapter.results
      phpunit_adapter.results = function(spec, result, tree)
        local parsed_results = original_results(spec, result, tree)
        
        if result.code == 0 and vim.tbl_isempty(parsed_results) then
          for _, node in tree:iter_nodes() do
            local data = node:data()
            if data.type == "test" then
              parsed_results[data.id] = {
                status = "passed",
                short = "Test passed (inferred from exit code 0)",
              }
            end
          end
        end
        
        if result.code == 0 then
          for test_id, test_result in pairs(parsed_results) do
            if test_result.status == "failed" or test_result.status == nil then
              test_result.status = "passed"
            end
          end
        end
        
        return parsed_results
      end

      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, phpunit_adapter)
      table.insert(opts.adapters, pest_adapter)
      
      return opts
    end,
  },
}
