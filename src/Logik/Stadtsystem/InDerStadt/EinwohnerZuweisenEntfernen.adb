pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with Karten;
with KartePositionPruefen;

package body EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
            EinwohnerBelegungÄndern (StadtRasseNummerExtern => StadtRasseNummerExtern);
         end if;

      else
         null;
      end if;
      
   end EinwohnerZuweisenEntfernen;



   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 YPositionExtern        => RelativeCursorPositionY,
                                                 XPositionExtern        => RelativeCursorPositionX)
      is
         when True =>
            EinwohnerEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                        
         when False =>
            EinwohnerZuweisen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end EinwohnerBelegungÄndern;
   
   
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   YPositionExtern        => RelativeCursorPositionY,
                                                   XPositionExtern        => RelativeCursorPositionX,
                                                   BelegenEntfernenExtern => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             ÄnderungExtern         => -1);
      
   end EinwohnerEntfernen;
   
   
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                  ÄnderungExtern    => (0, RelativeCursorPositionY, RelativeCursorPositionX));
         
      if
        KartenWert.XAchse = KartenKonstanten.LeerXAchse
      then
         null;
               
      elsif
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
      
   end EinwohnerZuweisen;

end EinwohnerZuweisenEntfernen;
