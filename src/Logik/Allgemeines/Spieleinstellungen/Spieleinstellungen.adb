pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Calendar; use Ada.Calendar;

with SonstigeVariablen;
with RassenDatentypen;
with SystemDatentypen;
with MenueDatentypen;

with ImSpiel;
with KartenGenerator;
with LadezeitenDatentypen;
with SpieleinstellungenKarten;
with SpieleinstellungenRasseSpieler;
with SpieleinstellungenSonstiges;
with Warnung;
with Ladezeiten;
with AuswahlMenues;

package body Spieleinstellungen is

   function Spieleinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SpielGespieltSchleife:
      loop
         ----------------------- Später auf Standardwerte für alles außer die Rassenbelegung festsetzen und dann nur prüfen ob eine Rasse belegt ist.
         SpielEinstellungenSchleife:
         loop
         
            Auswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Einstellungen_Menü_Enum);
         
            case
              Auswahl
            is
            when RueckgabeDatentypen.Auswahl_Kartengröße_Enum =>
               SpieleinstellungenKarten.KartengrößeWählen;

            when RueckgabeDatentypen.Auswahl_Kartenart_Enum =>
               SpieleinstellungenKarten.KartenartWählen;
               
            when RueckgabeDatentypen.Auswahl_Kartenform_Enum =>
               SpieleinstellungenKarten.KartenformWählen;

            when RueckgabeDatentypen.Auswahl_Kartentemperatur_Enum =>
               SpieleinstellungenKarten.KartentemperaturWählen;
               
            when RueckgabeDatentypen.Auswahl_Kartenressourcen_Enum =>
               SpieleinstellungenKarten.KartenressourcenWählen;

            when RueckgabeDatentypen.Auswahl_Rassen_Enum =>
               SpieleinstellungenRasseSpieler.RassenWählen;

            when RueckgabeDatentypen.Auswahl_Schwierigkeitsgrad_Enum =>
               SpieleinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               -- Oder eine Rasse zufällig belegen lassen?
               if
                 SpieleinstellungenRasseSpieler.EineRasseBelegt = True
               then
                  exit SpielEinstellungenSchleife;
                  
               else
                  null;
               end if;

            when RueckgabeDatentypen.Hauptmenü_Beenden_Enum'Range =>
               return Auswahl;

            when others =>
               null;
            end case;

         end loop SpielEinstellungenSchleife;
         
         Rückgabewert := AutomatischeEinstellungen;
         case
           Rückgabewert
         is
            when RueckgabeDatentypen.Spielmenü_Enum =>
               null;
               
            when others =>
               return Rückgabewert;
         end case;
      end loop SpielGespieltSchleife;
              
   end Spieleinstellungen;
   
   
   
   function AutomatischeEinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      KartenGenerator.KartenGenerator;
      
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Spieler_Platzieren_Enum, SystemDatentypen.Anfangswert_Enum) := Clock;
      SpieleinstellungenRasseSpieler.StartwerteErmitteln;
      RassenVorhanden := False;
      
      SicherheitsSchleife:
      for RassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RassenSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when RassenDatentypen.Spieler_Belegt_Enum'Range =>
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
            Warnung.LogikWarnung (WarnmeldungExtern => "SpielEinstellungen.AutomatischeEinstellungen - Es konnte keine Rasse platziert werden.");
            return RueckgabeDatentypen.Spielmenü_Enum;
      end case;
         
      LadezeitenDatentypen.SpielweltErstellenZeit (LadezeitenDatentypen.Spieler_Platzieren_Enum, SystemDatentypen.Endwert_Enum) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Spieler_Platzieren_Enum);

      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeitExtern => LadezeitenDatentypen.Gesamtzeit_Enum);
      
      return ImSpiel.ImSpiel;
      
   end AutomatischeEinstellungen;

end Spieleinstellungen;
