echo off
echo ===== Estedad-V6.1 Typeface Static fonts build =====
echo.
echo Generating Kashida masters:
echo ===========================
fontforge -script KashidaStyleGenerator.py Estedad Black
fontforge -script KashidaStyleGenerator.py Estedad Thin
echo Done!
echo.
echo Modifications of Kashida masters:
echo ================================================
fontforge -lang=ff -script modifications-of-Kashida-masters.pe Estedad-KThin.sfd
fontforge -lang=ff -script modifications-of-Kashida-masters.pe Estedad-KBlack.sfd
echo Done!
echo.
echo SFD to UFO Convertion:
echo ======================
fontforge -script sfd2ufo.py
echo Done!
echo.
echo writing GASP data to the generated UFOs:
echo ========================================
python save_gasp_to_ufo_files.py .\Estedad-Thin.ufo
python save_gasp_to_ufo_files.py .\Estedad-KThin.ufo
python save_gasp_to_ufo_files.py .\Estedad-Black.ufo
python save_gasp_to_ufo_files.py .\Estedad-KBlack.ufo
echo Done!
echo.
echo check_and_add_guideline_to_ufo(fontforge issue #4951):
echo ======================================================
python check_and_add_guideline_to_ufo.py .\Estedad-Thin.ufo
python check_and_add_guideline_to_ufo.py .\Estedad-KThin.ufo
python check_and_add_guideline_to_ufo.py .\Estedad-Black.ufo
python check_and_add_guideline_to_ufo.py .\Estedad-KBlack.ufo
echo Done!
echo.
echo convert all sfd to ttf and move to master_ttf folder:
echo =====================================================
fontforge -script sfd2ttf2master_ttfFolder.py
echo Done!
echo.
echo Interpolate instances:
echo ======================
fontmake --interpolate-binary-layout --round-instances -o ttf -m Estedad.designspace -i
echo round outline coordinates of all glyphs to integer values:
echo ==========================================================
fontforge -script round_to_int.py
echo Done!
echo.
echo refresh all ttf files:
echo ======================
fontforge -script refresh_ttf.py
echo Done!
echo.
echo set fsselection bit:
echo ====================
python fsselection.py instance_ttf\Estedad-Thin.ttf instance_ttf\Estedad-Thin.ttf
python fsselection.py instance_ttf\Estedad-ExtraLight.ttf instance_ttf\Estedad-ExtraLight.ttf
python fsselection.py instance_ttf\Estedad-Light.ttf instance_ttf\Estedad-Light.ttf
python fsselection.py instance_ttf\Estedad-Regular.ttf instance_ttf\Estedad-Regular.ttf
python fsselection.py instance_ttf\Estedad-Medium.ttf instance_ttf\Estedad-Medium.ttf
python fsselection.py instance_ttf\Estedad-SemiBold.ttf instance_ttf\Estedad-SemiBold.ttf
python fsselection.py instance_ttf\Estedad-Bold.ttf instance_ttf\Estedad-Bold.ttf
python fsselection.py instance_ttf\Estedad-ExtraBold.ttf instance_ttf\Estedad-ExtraBold.ttf
python fsselection.py instance_ttf\Estedad-Black.ttf instance_ttf\Estedad-Black.ttf
echo Done!
echo.
echo add meta/prep/avar:
echo ===================
CMD /c ttx -m instance_ttf\Estedad-Thin.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-Thin.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-ExtraLight.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-ExtraLight.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-Light.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-Light.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-Regular.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-Regular.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-Medium.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-Medium.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-SemiBold.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-SemiBold.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-Bold.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-Bold.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-ExtraBold.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-ExtraBold.ttf \instance_ttf
CMD /c ttx -m instance_ttf\Estedad-Black.ttf meta-prep.ttx
python rename_move.py \meta-prep.ttf \Estedad-Black.ttf \instance_ttf
echo Done!
echo.
echo rename instance_ttf folder to Statics:
echo ======================================
python rename_folder.py instance_ttf Statics
echo Done!
echo.
echo Delete Junk Files:
echo ==================
CMD /c delete_junk_files.bat
echo Done!
echo.
echo All Done!
echo.
pause