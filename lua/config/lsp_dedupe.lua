local function dedupe_locations(locations)
  if not locations or vim.tbl_isempty(locations) then
    return locations
  end

  if not vim.tbl_islist(locations) then
    locations = { locations }
  end

  local seen = {}
  local unique = {}

  for _, loc in ipairs(locations) do
    local uri = loc.uri or loc.targetUri
    local range = loc.range or loc.targetSelectionRange or loc.targetRange

    if uri and range and range.start then
      local key = string.format("%s:%d:%d", uri, range.start.line, range.start.character)

      if not seen[key] then
        seen[key] = true
        table.insert(unique, loc)
      end
    end
  end

  return unique
end

local original_handler = vim.lsp.handlers["textDocument/definition"]

vim.lsp.handlers["textDocument/definition"] = function(err, result, ctx, config)
  if result then
    result = dedupe_locations(result)
  end
  return original_handler(err, result, ctx, config)
end

local original_references = vim.lsp.handlers["textDocument/references"]
vim.lsp.handlers["textDocument/references"] = function(err, result, ctx, config)
  if result then
    result = dedupe_locations(result)
  end
  return original_references(err, result, ctx, config)
end

local original_implementation = vim.lsp.handlers["textDocument/implementation"]
vim.lsp.handlers["textDocument/implementation"] = function(err, result, ctx, config)
  if result then
    result = dedupe_locations(result)
  end
  return original_implementation(err, result, ctx, config)
end

return {}
