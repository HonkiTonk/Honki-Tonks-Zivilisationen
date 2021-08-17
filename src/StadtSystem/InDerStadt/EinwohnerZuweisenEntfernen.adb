pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten, KartePositionPruefen, LeseKarten;

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
         NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) = True
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
           := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) - 1;
                        
      else         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                     ÄnderungExtern    => (0, RelativeCursorPositionY, RelativeCursorPositionX));
         
         case
           KartenWert.XAchse
         is
            when GlobaleKonstanten.LeerYXKartenWert =>
               null;
               
            when others =>                 
               if
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
                 < GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
                 and
                   LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         KoordinatenExtern      => KartenWert) = True
               then
                  GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
                  GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
                    := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + 1;
            
               else
                  null;
               end if;
         end case;
      end if;
      
   end EinwohnerZuweisen;

end EinwohnerZuweisenEntfernen;
