with KartenKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with StadtfeldBewertenLogik;

package body FelderbewirtschaftungLogik is

   procedure BewirtschaftbareFelderBelegen
     (ZuwachsSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Einwohner;
   begin
      
      case
        ZuwachsSchwundExtern
      is
         when False =>
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True,
                                                   WachsenSchrumpfenExtern => False);
            
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              >= LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => False)
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            null;
      end case;
      
      ArbeiterBelegenEntfernen (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                BelegenEntfernenExtern  => ZuwachsSchwundExtern,
                                WachsenSchrumpfenExtern => ZuwachsSchwundExtern,
                                FeldExtern              => OptimalesFeldErmitteln (ZuwachsSchwundExtern   => ZuwachsSchwundExtern,
                                                                                   StadtRasseNummerExtern => StadtRasseNummerExtern));
      
   end BewirtschaftbareFelderBelegen;
   
   
   
   function OptimalesFeldErmitteln
     (ZuwachsSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return FeldRecord
   is
      use type KartenDatentypen.Kartenfeld;
      use type ProduktionDatentypen.Produktion;
   begin
      
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Feld.Bewertung := ProduktionDatentypen.Stadtproduktion'First;
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);

      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            Bewertung := ProduktionDatentypen.Stadtproduktion'First;
            
            if
              Kartenwert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               KoordinatenExtern      => Kartenwert)
            then
               null;
              
            elsif
              ZuwachsSchwundExtern = LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                              YKoordinateExtern      => YAchseSchleifenwert,
                                                                              XKoordinateExtern      => XAchseSchleifenwert)
            then
               null;
               
            else
               Bewertung := StadtfeldBewertenLogik.FeldBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 KoordinatenExtern      => Kartenwert,
                                                                 BelegenEntfernenExtern => ZuwachsSchwundExtern);
            end if;
            
            if
              Feld.Bewertung < Bewertung
            then
               Feld := (Bewertung, YAchseSchleifenwert, XAchseSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return Feld;
      
   end OptimalesFeldErmitteln;
   
   
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean;
      FeldExtern : in FeldRecord)
   is begin
      
      case
        FeldExtern.Bewertung
      is
         when ProduktionDatentypen.Stadtproduktion'First =>
            null;
            
         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         YKoordinateExtern      => FeldExtern.YKoordinate,
                                                         XKoordinateExtern      => FeldExtern.XKoordinate,
                                                         BelegenEntfernenExtern => BelegenEntfernenExtern);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => False,
                                                   WachsenSchrumpfenExtern => WachsenSchrumpfenExtern);
      end case;
      
   end ArbeiterBelegenEntfernen;

end FelderbewirtschaftungLogik;
