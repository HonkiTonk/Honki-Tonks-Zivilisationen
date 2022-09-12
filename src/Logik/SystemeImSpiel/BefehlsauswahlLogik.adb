pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen; use TastenbelegungDatentypen;

with TasteneingabeLogik;
with CursorbewegungLogik;
with ForschungsauswahlLogik;
with NaechstesObjekt;
with DiplomatieLogik;
with EinheitenmodifizierungLogik;
with DebugmenueLogik;
with BefehlspruefungenLogik;
with StadtSuchen;
with MausauswahlLogik;

package body BefehlsauswahlLogik is

   -- Kann man nicht auch hier eine Schleife einbauen und sich das Zurückgehen sparen? äöü
   -- Nicht so einfach da ja diverse Dinge geprüft werden müssen. äöü
   -- Also entweder weiter durch ImSpiel aufrufen oder die wichtigsten Prüfungen hierher verschieben? äöü
   function Befehlsauswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Mausbefehl := MausauswahlLogik.Weltkartenbefehle;
      
      case
        Mausbefehl
      is
         when BefehleDatentypen.Leer_Enum =>
            return Tasteneingabe (RasseExtern => RasseExtern);
            
         when others =>
            return Befehlsknöpfe (RasseExtern => RasseExtern);
      end case;
      
   end Befehlsauswahl;
   
   
   
   function Tasteneingabe
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Befehl := TasteneingabeLogik.Tastenwert;

      case
        Befehl
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Ebene_Enum'Range =>
            CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => Befehl,
                                                         RasseExtern    => RasseExtern);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            BefehlspruefungenLogik.AuswahlEinheitStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Menü_Zurück_Enum =>
            return RueckgabeDatentypen.Spielmenü_Enum;

         when TastenbelegungDatentypen.Bauen_Enum =>
            BefehlspruefungenLogik.BaueStadt (RasseExtern => RasseExtern);
           
         when TastenbelegungDatentypen.Forschung_Enum =>
            ForschungsauswahlLogik.Forschung (RasseExtern => RasseExtern);
            
            -- Die folgenden vier Befehle scheinen gar nicht mehr zu funktionieren. äöü
            -- So anpassen wie GeheZu. äöü
         when TastenbelegungDatentypen.Nächste_Stadt_Enum =>
            NaechstesObjekt.NächsteStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Hat_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Alle_Einheiten_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Egal_Bewegeungspunkte);
            
         when TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum =>
            NaechstesObjekt.NächsteEinheit (RasseExtern           => RasseExtern,
                                             BewegungspunkteExtern => NaechstesObjekt.Keine_Bewegungspunkte);
            
         when TastenbelegungDatentypen.Tastenbelegung_Befehle_Enum'Range =>
            if
              Befehl = TastenbelegungDatentypen.Auflösen_Enum
            then
               BefehlspruefungenLogik.WasWirdEntfernt (RasseExtern => RasseExtern);
               
            else
               BefehlspruefungenLogik.EinheitBefehle (RasseExtern  => RasseExtern,
                                                      BefehlExtern => Befehl);
            end if;

         when TastenbelegungDatentypen.Diplomatie_Enum =>
            DiplomatieLogik.DiplomatieMöglich (RasseExtern => RasseExtern);

         when TastenbelegungDatentypen.Gehe_Zu_Enum =>
            CursorbewegungLogik.GeheZu;

         when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
            BefehlspruefungenLogik.StadtUmbenennen (RasseExtern => RasseExtern);
            
            -- Das hier muss vermutlich auch mal überarbeitet werden. äöü
         when TastenbelegungDatentypen.Stadt_Suchen_Enum =>
            StadtSuchenNachNamen := StadtSuchen.StadtNachNamenSuchen;
            
         when TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum =>
            NaechstesObjekt.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum =>
            NaechstesObjekt.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenmodifizierungLogik.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when TastenbelegungDatentypen.Runde_Beenden_Enum =>
            return RueckgabeDatentypen.Runde_Beenden_Enum;
            
         when TastenbelegungDatentypen.Debugmenü_Enum =>
            DebugmenueLogik.Debugmenü (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum | TastenbelegungDatentypen.Tastenbelegung_Bewegung_Numblock_Enum'Range =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Tasteneingabe;
   
   
   
   function Befehlsknöpfe
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Befehlsknöpfe;

end BefehlsauswahlLogik;
