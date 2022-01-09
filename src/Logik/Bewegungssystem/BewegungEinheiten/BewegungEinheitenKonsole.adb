pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with GlobaleTexte;

with Karte;
with Eingabe;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with Anzeige;
with BewegungEinheiten;

package body BewegungEinheitenKonsole is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

      BewegenSchleife:
      loop
         
         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
         is
            when SystemDatentypen.Oben =>
               Änderung := (0, -1, 0);
            
            when SystemDatentypen.Links =>
               Änderung := (0, 0, -1);
            
            when SystemDatentypen.Unten =>
               Änderung := (0, 1, 0);
            
            when SystemDatentypen.Rechts  =>
               Änderung := (0, 0, 1);
            
            when SystemDatentypen.Links_Oben =>
               Änderung := (0, -1, -1);
            
            when SystemDatentypen.Rechts_Oben =>
               Änderung := (0, -1, 1);
            
            when SystemDatentypen.Links_Unten =>
               Änderung := (0, 1, -1);

            when SystemDatentypen.Rechts_Unten =>
               Änderung := (0, 1, 1);
            
            when SystemDatentypen.Ebene_Hoch =>
               Änderung := (1, 0, 0);
            
            when SystemDatentypen.Ebene_Runter =>
               Änderung := (-1, 0, 0);
               
            when SystemDatentypen.Heimatstadt_Ändern =>
               EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
               
            when SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | SystemDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
               AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    BefehlExtern             => Befehl);
               
               case
                 AufgabeDurchführen
               is
                  when True =>
                     return;
               
                  when False =>
                     Änderung := KeineÄnderung;
                     Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                           TextZeileExtern => 2);
               end case;
               
            when SystemDatentypen.Bauen =>
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
