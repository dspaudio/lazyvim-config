return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              environment = {
                phpVersion = "8.4.0", -- PHP 8.4 버전 명시
              },
              files = {
                maxSize = 5000000, -- 5MB
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

