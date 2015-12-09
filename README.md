# windows_serverspec_example
Example repo with working Serverspec tests against Windows 2012 R2


This simple repo includes a working Rakefile, spec_helper, and sample tests against a Windows IIS server and app pool.  It includes validations of networking components, IIS features, users, AppPool and .NET versions, registry keys, and a simple spot check of a website's home page.

# Dependencies
This repo was tested using the ruby environment embedded in ChefDK version 0.10.0.  Please install that omnibus package to ensure dependencies are met correctly, then clone the repository locally on a target server, move into the repo root in a PowerShell session, and run:
`rake spec`

# Author
Dave Tashner, SingleStone 2015
