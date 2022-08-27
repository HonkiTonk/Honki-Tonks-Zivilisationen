pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with ProduktionDatentypen; use ProduktionDatentypen;
with KartenKonstanten;

with LeseKarten;
with LeseStadtGebaut;
with SchreibeStadtGebaut;

with Karten;
with Kartenkoordinatenberechnungssystem;

package body EinwohnerZuweisenEntfernen is

   procedure EinwohnerZuweisenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse < Karten.Stadtkarte'First (1) + 7
        and
          SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse > Karten.Stadtkarte'Last (2) - 7
      then
         RelativeCursorPositionY := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.YAchse - 4;
         RelativeCursorPositionX := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenStadt.XAchse - 17;
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
            EinwohnerBelegungÄndern (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      YAchseExtern           => RelativeCursorPositionY,
                                      XAchseExtern           => RelativeCursorPositionX);
         end if;

      else
         null;
      end if;
      
   end EinwohnerZuweisenEntfernen;



   procedure EinwohnerBelegungÄndern
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      case
        LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 YKoordinateExtern      => YAchseExtern,
                                                 XKoordinateExtern      => XAchseExtern)
      is
         when True =>
            EinwohnerEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                YAchseExtern           => YAchseExtern,
                                XAchseExtern           => XAchseExtern);
                        
         when False =>
            EinwohnerZuweisen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               YAchseExtern           => YAchseExtern,
                               XAchseExtern           => XAchseExtern);
      end case;
      
   end EinwohnerBelegungÄndern;
   
   
   
   procedure EinwohnerEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                   YKoordinateExtern      => YAchseExtern,
                                                   XKoordinateExtern      => XAchseExtern,
                                                   BelegenEntfernenExtern => False);
      
      SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                             EinwohnerArbeiterExtern => False,
                                             WachsenSchrumpfenExtern => False);
      
   end EinwohnerEntfernen;
   
   
   
   procedure EinwohnerZuweisen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      YAchseExtern : in KartenDatentypen.Kartenfeld;
      XAchseExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                           ÄnderungExtern    => (0, YAchseExtern, XAchseExtern),
                                                                                           LogikGrafikExtern => True);
         
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => False)
              < LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True)
              and
                True = LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             KoordinatenExtern      => KartenWert)
            then
               SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            YKoordinateExtern      => YAchseExtern,
                                                            XKoordinateExtern      => XAchseExtern,
                                                            BelegenEntfernenExtern => True);
               SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                      EinwohnerArbeiterExtern => False,
                                                      WachsenSchrumpfenExtern => True);
            
            else
               null;
            end if;
      end case;
      
   end EinwohnerZuweisen;

end EinwohnerZuweisenEntfernen;
