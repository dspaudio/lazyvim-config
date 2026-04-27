return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- 브랜치 전환 시 대량 파일 변경으로 LSP가 폭주하는 문제 차단
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
      servers = {
        phpactor = {
          enabled = false,
        },
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                phpVersion = "8.4.0", -- PHP 8.4 버전 명시
              },
              files = {
                maxSize = 5000000,
                exclude = {
                  "**/.git/**",
                  "**/node_modules/**",
                  "**/vendor/**/Tests/**",
                  "**/vendor/**/tests/**",
                },
              },
              stubs = {
                "apache", "bcmath", "Core", "ctype", "curl", "date",
                "dom", "fileinfo", "filter", "ftp", "gd", "gettext",
                "hash", "iconv", "json", "libxml", "mbstring", "mysqli",
                "mysqlnd", "openssl", "pcre", "PDO", "pdo_mysql", "Phar",
                "posix", "readline", "Reflection", "session", "SimpleXML",
                "sockets", "sodium", "SPL", "standard", "tokenizer", "xml",
                "xmlreader", "xmlwriter", "yaml", "zip", "zlib",
                "laravel", "phpunit", "wordpress",
              },
              diagnostics = {
                deprecated = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "intelephense" },
    },
  },
}

