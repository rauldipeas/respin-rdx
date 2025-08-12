#!/bin/bash/env pwsh
scp -r site/* rauldipeas@web.sourceforge.net:/home/project-web/respin-rdx/htdocs/
surge site https://respin-rdx.surge.sh
wrangler pages deploy site --project-name respin-rdx --commit-dirty=true;Remove-Item .\.wrangler