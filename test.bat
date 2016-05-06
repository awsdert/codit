@echo on
@setlocal DisableDelayedExpansion

for /f "tokens=*" %%L in (.git/logs/HEAD) do (
	if "%%L"=="" (
		for /f "tokens=5* delims= " %%I in (%V%) do (
			set N=%%I
			if "%%I"=="" echo (
				"#include \"CoditBuild.h\"\n"
				"unsigned long CODIT_COMMIT = %N%;"
			) >src/CoditCommit.c
			set P=%%I
		)
	)
	set V="%%L"
)

@endlocal
:exit
