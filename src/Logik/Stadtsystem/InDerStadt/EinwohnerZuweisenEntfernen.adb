pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with Karten;
with KarteKoordinatenPruefen;

package body EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      if
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse < Karten.Stadtkarte'First (1) + 7
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse > Karten.Stadtkarte'Last (2) - 7
      then
         RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse - 4;
         RelativeCursorPositionX := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse - 17;
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
                                                 YKoordinateExtern      => RelativeCursorPositionY,
                                                 XKoordinateExtern      => RelativeCursorPositionX)
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
                                                   YKoordinateExtern      => RelativeCursorPositionY,
                                                   XKoordinateExtern      => RelativeCursorPositionX,
                                                   BelegenEntfernenExtern => False);
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             ÄnderungExtern         => -1);
      
   end EinwohnerEntfernen;
   
   
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                     ÄnderungExtern    => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                     LogikGrafikExtern => True);
         
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
                                                      YKoordinateExtern      => RelativeCursorPositionY,
                                                      XKoordinateExtern      => RelativeCursorPositionX,
                                                      BelegenEntfernenExtern => True);
         SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                EinwohnerArbeiterExtern => False,
                                                ÄnderungExtern         => 1);
            
      else
         null;
      end if;
      
   end EinwohnerZuweisen;

end EinwohnerZuweisenEntfernen;
