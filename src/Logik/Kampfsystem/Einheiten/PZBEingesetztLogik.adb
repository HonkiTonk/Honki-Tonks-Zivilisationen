pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtKonstanten;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;

with EinheitenErzeugenEntfernenLogik;
with KartenkoordinatenberechnungssystemLogik;
with StadtEntfernenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;

package body PZBEingesetztLogik is

   function PZBEingesetzt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Einheitenart := LeseEinheitenDatenbank.EinheitArt (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                         IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        Einheitenart
      is
         when EinheitenDatentypen.PZB_Enum'Range =>
            PZBGezündet := PZBGezündet + 1;
            SpielVariablen.Allgemeines.PlanetVernichtet := EinheitRasseNummerExtern.Rasse;
            
         when others =>
            return False;
      end case;
      
      case
        SpielVariablen.Allgemeines.Zusammenbruchszeit
      is
         when -1 =>
            if
              Weltkarte.Karteneinstellungen.Kartengröße.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
            then
               SpielVariablen.Allgemeines.Zusammenbruchszeit := Natural (abs (Weltkarte.Karteneinstellungen.Kartengröße.YAchse - Kartengrößen (Einheitenart)) / 10);
                  
            else
               SpielVariablen.Allgemeines.Zusammenbruchszeit := Natural (abs (Weltkarte.Karteneinstellungen.Kartengröße.XAchse - Kartengrößen (Einheitenart)) / 10 );
            end if;
               
         when others =>
            if
              Weltkarte.Karteneinstellungen.Kartengröße.YAchse <= Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              and
                SpielVariablen.Allgemeines.Zusammenbruchszeit > Natural (abs (Weltkarte.Karteneinstellungen.Kartengröße.YAchse - Kartengrößen (Einheitenart)) / 10) / PZBGezündet
            then
               SpielVariablen.Allgemeines.Zusammenbruchszeit := Natural (abs (Weltkarte.Karteneinstellungen.Kartengröße.YAchse - Kartengrößen (Einheitenart)) / 10) / PZBGezündet;
               
            elsif
              Weltkarte.Karteneinstellungen.Kartengröße.YAchse > Weltkarte.Karteneinstellungen.Kartengröße.XAchse
              and
                SpielVariablen.Allgemeines.Zusammenbruchszeit > Natural (abs (Weltkarte.Karteneinstellungen.Kartengröße.XAchse - Kartengrößen (Einheitenart)) / 10) / PZBGezündet
            then
               SpielVariablen.Allgemeines.Zusammenbruchszeit := Natural (abs (Weltkarte.Karteneinstellungen.Kartengröße.XAchse - Kartengrößen (Einheitenart)) / 10) / PZBGezündet;
                  
            else
               null;
            end if;
      end case;
         
      PlanetenVernichten (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
            
      return True;
      
   end PZBEingesetzt;
   
   
   
   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbeneVorhanden'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in -Kartengrößen (Einheitenart) / 2 .. Kartengrößen (Einheitenart) / 2 loop
            XAchseSchleife:
            for XAchseSchleifenwert in -Kartengrößen (Einheitenart) / 2 .. Kartengrößen (Einheitenart) / 2 loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EAchseSchleifenwert, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                                         ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               case
                 Kartenwert.EAchse
               is
                  when KartenKonstanten.LeerEAchse =>
                     null;
                     
                  when others =>
                     FeldVernichten (KoordinatenExtern => Kartenwert);
               end case;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end PlanetenVernichten;
   
   
   
   procedure FeldVernichten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Einheit := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                       LogikGrafikExtern => True);
      
      case
        Einheit.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => Einheit);
      end case;
      
      Stadt := StadtSuchenLogik.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern);
      
      case
        Stadt.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
            
         when others =>
            StadtEntfernenLogik.StadtEntfernen (StadtRasseNummerExtern => Stadt);
      end case;
      
      SchreibeWeltkarte.GleicherGrund (KoordinatenExtern => KoordinatenExtern,
                                       GrundExtern       => KartengrundDatentypen.Vernichtet_Enum);
      SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                               FlussExtern       => KartengrundDatentypen.Leer_Fluss_Enum);
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                      VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                   RessourceExtern   => KartengrundDatentypen.Leer_Ressource_Enum);
      SchreibeWeltkarte.Bewertung (KoordinatenExtern => KoordinatenExtern,
                                   RasseExtern       => RassenDatentypen.Keine_Rasse_Enum,
                                   BewertungExtern   => 0);
      
   end FeldVernichten;

end PZBEingesetztLogik;
