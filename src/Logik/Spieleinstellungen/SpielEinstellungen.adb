pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with GlobaleVariablen;

with ImSpiel;
with KartenGenerator;
with LadezeitenDatentypen;
with SpielEinstellungenKarten;
with SpielEinstellungenRasseSpieler;
with SpielEinstellungenSonstiges;
with Fehler;
with Ladezeiten;
-- with AuswahlMenue:

package body SpielEinstellungen is

   function Spieleinstellungen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      ----------------------- Später auf Standardwerte für alles außer die Rassenbelegung festsetzen und dann nur prüfen ob eine Rasse belegt ist.
      Auswahl := SystemDatentypen.Auswahl_Kartengröße_Enum;

      SpielEinstellungenSchleife:
      loop
         
         -- case
         --   AuswahlMenue.AuswahlMenü (WelchesMenüExtern => SystemDatentypen.Einstellungen_Menü_Enum)
         -- is
            
         case
           Auswahl
         is
            when SystemDatentypen.Auswahl_Kartengröße_Enum =>
               Auswahl := SpielEinstellungenKarten.KartengrößeWählen;

            when SystemDatentypen.Auswahl_Kartenart_Enum =>
               Auswahl := SpielEinstellungenKarten.KartenartWählen;
               
            when SystemDatentypen.Auswahl_Kartenform_Enum =>
               Auswahl := SpielEinstellungenKarten.KartenformWählen;

            when SystemDatentypen.Auswahl_Kartentemperatur_Enum =>
               Auswahl := SpielEinstellungenKarten.KartentemperaturWählen;
               
            when SystemDatentypen.Auswahl_Kartenressourcen_Enum =>
               Auswahl := SpielEinstellungenKarten.KartenressourcenWählen;

            when SystemDatentypen.Auswahl_Rassen_Enum =>
               Auswahl := SpielEinstellungenRasseSpieler.RassenWählen;

            when SystemDatentypen.Auswahl_Schwierigkeitsgrad_Enum =>
               Auswahl := SpielEinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
            when SystemDatentypen.Start_Weiter_Enum =>
               exit SpielEinstellungenSchleife;

            when SystemDatentypen.Zurück_Beenden_Enum'Range =>
               return Auswahl;

            when others =>
               null;
         end case;

      end loop SpielEinstellungenSchleife;

      return AutomatischeEinstellungen;
              
   end Spieleinstellungen;
   
   
   
   function AutomatischeEinstellungen
     return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenGenerator.KartenGenerator;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Spieler_Platzieren_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      SpielEinstellungenRasseSpieler.StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when SystemDatentypen.Leer_Spieler_Enum =>
               null;
               
            when SystemDatentypen.Spieler_Mensch_Enum | SystemDatentypen.Spieler_KI_Enum =>
               RassenVorhanden := True;
               exit SicherheitsSchleife;
         end case;
         
      end loop SicherheitsSchleife;
      
      case
        RassenVorhanden
      is
         when True =>
            null;
            
         when False =>
            Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungen.AutomatischeEinstellungen - Es konnte keine Rasse platziert werden.");
      end case;
         
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Spieler_Platzieren_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Spieler_Platzieren_Enum);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Gesamtzeit_Enum);
      
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end SpielEinstellungen;
