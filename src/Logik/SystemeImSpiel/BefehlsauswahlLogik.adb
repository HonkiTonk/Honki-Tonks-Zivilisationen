pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen; use TastenbelegungDatentypen;

with TasteneingabeLogik;
with CursorbewegungLogik;
with ForschungsauswahlLogik;
with DiplomatieLogik;
with EinheitenmodifizierungLogik;
with DebugmenueLogik;
with BefehlspruefungenLogik;
with StadtSuchenLogik;
with MausauswahlLogik;
with NaechsteEinheitLogik;
with NaechsteStadtLogik;

package body BefehlsauswahlLogik is

   -- Kann man nicht auch hier eine Schleife einbauen und sich das Zurückgehen sparen? äöü
   -- Nicht so einfach da ja diverse Dinge geprüft werden müssen. äöü
   -- Also entweder weiter durch SpielLogik aufrufen oder die wichtigsten Prüfungen hierher verschieben? äöü
   -- Oder SpielLogik in zwei Teile aufteilen? äöü
   function Befehlsauswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Befehl := TasteneingabeLogik.Tastenwert;
      
      case
        Befehl
      is
         when TastenbelegungDatentypen.Auswählen_Enum =>
            return Tasteneingabe (RasseExtern  => RasseExtern,
                                  BefehlExtern => MausauswahlLogik.Weltkartenbefehle);
            
         when others =>
            return Tasteneingabe (RasseExtern  => RasseExtern,
                                  BefehlExtern => Befehl);
      end case;
      
   end Befehlsauswahl;
   
   
   
   function Tasteneingabe
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin

      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Ebene_Enum'Range =>
            CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => BefehlExtern,
                                                         RasseExtern    => RasseExtern);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            BefehlspruefungenLogik.AuswahlEinheitStadt (RasseExtern => RasseExtern);
            
            -- Hier noch Zeug einbauen. äöü
         when TastenbelegungDatentypen.Entladen_Enum =>
            null;
            
         when TastenbelegungDatentypen.Menü_Zurück_Enum =>
            return RueckgabeDatentypen.Spielmenü_Enum;

         when TastenbelegungDatentypen.Bauen_Enum =>
            BefehlspruefungenLogik.BaueStadt (RasseExtern => RasseExtern);
           
         when TastenbelegungDatentypen.Forschung_Enum =>
            ForschungsauswahlLogik.Forschung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Nächste_Stadt_Enum =>
            NaechsteStadtLogik.NächsteStadt (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum =>
            NaechsteEinheitLogik.NächsteEinheit (RasseExtern           => RasseExtern,
                                                  BewegungspunkteExtern => NaechsteEinheitLogik.Hat_Bewegungspunkte_Enum);
            
         when TastenbelegungDatentypen.Alle_Einheiten_Enum =>
            NaechsteEinheitLogik.NächsteEinheit (RasseExtern           => RasseExtern,
                                                  BewegungspunkteExtern => NaechsteEinheitLogik.Egal_Bewegeungspunkte_Enum);
            
         when TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum =>
            NaechsteEinheitLogik.NächsteEinheit (RasseExtern           => RasseExtern,
                                                  BewegungspunkteExtern => NaechsteEinheitLogik.Keine_Bewegungspunkte_Enum);
            
         when TastenbelegungDatentypen.Tastenbelegung_Befehle_Baulos_Enum'Range =>
            if
              BefehlExtern = TastenbelegungDatentypen.Auflösen_Enum
            then
               BefehlspruefungenLogik.WasWirdEntfernt (RasseExtern => RasseExtern);
               
            else
               BefehlspruefungenLogik.EinheitBefehle (RasseExtern  => RasseExtern,
                                                      BefehlExtern => BefehlExtern);
            end if;

         when TastenbelegungDatentypen.Diplomatie_Enum =>
            DiplomatieLogik.DiplomatieMöglich (RasseExtern => RasseExtern);

         when TastenbelegungDatentypen.Gehe_Zu_Enum =>
            CursorbewegungLogik.GeheZu;

         when TastenbelegungDatentypen.Stadt_Umbenennen_Enum =>
            BefehlspruefungenLogik.StadtUmbenennen (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Stadt_Suchen_Enum =>
            StadtSuchenLogik.StadtNachNamenSuchen;
            
         when TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum =>
            NaechsteStadtLogik.NächsteStadtMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum =>
            NaechsteEinheitLogik.NächsteEinheitMeldung (RasseExtern => RasseExtern);
            
         when TastenbelegungDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenmodifizierungLogik.HeimatstadtÄndern (EinheitRasseNummerExtern => (RasseExtern, 0));
            
         when TastenbelegungDatentypen.Runde_Beenden_Enum =>
            return RueckgabeDatentypen.Runde_Beenden_Enum;
            
         when TastenbelegungDatentypen.Debugmenü_Enum =>
            DebugmenueLogik.Debugmenü (RasseExtern => RasseExtern);
            
            -- Das hier irgendwann auch wieder einbauen? äöü
            -- Oder ist das mit dem aktuellen System komplett sinnfrei? äöü
            -- Eventuelle über GeheZu regeln? äöü
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Numblock_Enum'Range =>
            null;
            
         when TastenbelegungDatentypen.Leer_Tastenbelegung_Enum =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Tasteneingabe;

end BefehlsauswahlLogik;
