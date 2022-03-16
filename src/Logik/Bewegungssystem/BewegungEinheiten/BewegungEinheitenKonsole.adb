pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleTexte;

with Karte;
with Eingabe;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with TextAnzeigeKonsole;
with BewegungEinheiten;

package body BewegungEinheitenKonsole is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

      BewegenSchleife:
      loop
         
         Änderung := KeineÄnderung;
         
         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
         is
            when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
               Änderung := Richtung (Befehl);
               
            when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
               EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
               
            when TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | TastenbelegungDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
               AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    BefehlExtern             => Befehl);
               
               case
                 AufgabeDurchführen
               is
                  when True =>
                     return;
               
                  when False =>
                     Änderung := KeineÄnderung;
                     TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                                      TextZeileExtern => 2);
               end case;
               
            when TastenbelegungDatentypen.Bauen_Enum =>
               NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
            
            when others =>
               return;
         end case;
         
         if
           Änderung = KeineÄnderung
         then
            BewegungNochMöglich := BewegungEinheiten.NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            BewegungNochMöglich := BewegungEinheiten.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                       PositionÄnderungExtern  => Änderung);
         end if;
         
         case
           BewegungNochMöglich
         is
            when True =>
               null;
               
            when False =>
               return;
         end case;

         -- Diesen Wert hier immer wieder auf Karte anzeigen setzen und nicht mehr die Karte direkt aufrufen.
         Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;

end BewegungEinheitenKonsole;
