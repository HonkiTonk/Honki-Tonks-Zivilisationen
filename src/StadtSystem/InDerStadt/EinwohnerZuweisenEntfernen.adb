pragma SPARK_Mode (On);

with GlobaleKonstanten;

with LeseKarten, LeseStadtGebaut, SchreibeStadtGebaut;

with Karten, KartePositionPruefen;

package body EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7
      then
         RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse - 4;
         RelativeCursorPositionX := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse - 17;
         NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
         if
         abs (RelativeCursorPositionY) > NutzbarerBereich
           or
         abs (RelativeCursorPositionX) > NutzbarerBereich
         then
            null;
                  
         elsif
           RelativeCursorPositionY = 0
           and
             RelativeCursorPositionX = 0
         then
            null;
                  
         else
            EinwohnerZuweisen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end if;

      else
         null;
      end if;
      
   end EinwohnerZuweisenEntfernen;



   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      if
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 YPositionExtern        => RelativeCursorPositionY,
                                                 XPositionExtern        => RelativeCursorPositionX)
        = True
      then
         SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      YPositionExtern        => RelativeCursorPositionY,
                                                      XPositionExtern        => RelativeCursorPositionX,
                                                      BelegenEntfernenExtern => False);
         SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => False,
                                                ÄnderungExtern         => -1);
                        
      else         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                     ÄnderungExtern    => (0, RelativeCursorPositionY, RelativeCursorPositionX));
         
         case
           KartenWert.XAchse
         is
            when GlobaleKonstanten.LeerYXKartenWert =>
               null;
               
            when others =>                 
               if
                 LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => False)
                 <
                 LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => True)
                 and
                   LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         KoordinatenExtern      => KartenWert)
                 = True
               then
                  SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               YPositionExtern        => RelativeCursorPositionY,
                                                               XPositionExtern        => RelativeCursorPositionX,
                                                               BelegenEntfernenExtern => True);
                  SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                         EinwohnerArbeiterExtern => False,
                                                         ÄnderungExtern         => 1);
            
               else
                  null;
               end if;
         end case;
      end if;
      
   end EinwohnerZuweisen;

end EinwohnerZuweisenEntfernen;
