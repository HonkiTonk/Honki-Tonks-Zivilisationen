pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with InteraktionAuswahl;
with GrafikDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;
with MenueDatentypen;

with NachGrafiktask;
with EingabeLogik;
with Mausauswahl;
with Auswahlaufteilungen;
with Fehler;
with DiplomatischerZustandAenderbar;
with EinheitVerschieben;
with Handeln;

package body Diplomatie is
   
   procedure DiplomatieMöglich
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      Rassenprüfungen (RasseExtern => RasseExtern);
      Diplomatie (RasseExtern => RasseExtern);
      
   end DiplomatieMöglich;
   
   
   
   procedure Rassenprüfungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      RassenSchleife:
      for RassenSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           RassenSchleifenwert = RasseExtern
           or
             SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Leer_Spieler_Enum
           or
             SpielVariablen.Diplomatie (RasseExtern, RassenSchleifenwert).AktuellerZustand = DiplomatieDatentypen.Unbekannt_Enum
         then
            InteraktionAuswahl.RassenMöglich (RassenSchleifenwert) := False;
            
         else
            InteraktionAuswahl.RassenMöglich (RassenSchleifenwert) := True;
         end if;
         
      end loop RassenSchleife;
      
   end Rassenprüfungen;
   
   
   
   procedure Diplomatie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      DiplomatieSchleife:
      loop
         
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Diplomatie_Enum;
         
         RassenauswahlSchleife:
         loop
            
            Auswahl := Mausauswahl.RassenauswahlDiplomatie;
            NachGrafiktask.AktuelleAuswahl.AuswahlEins := Auswahl;
                        
            case
              EingabeLogik.Tastenwert
            is
               when TastenbelegungDatentypen.Auswählen_Enum =>
                  if
                    Auswahl = SystemKonstanten.LeerAuswahl
                  then
                     null;
                  
                  else
                     KontaktierteRasse := RassenDatentypen.Rassen_Verwendet_Enum'Val (Auswahl);
                     NachGrafiktask.KontaktierteRasse := KontaktierteRasse;
                     exit RassenauswahlSchleife;
                  end if;
               
               when TastenbelegungDatentypen.Menü_Zurück_Enum =>
                  return;
               
               when others =>
                  null;
            end case;
            
         end loop RassenauswahlSchleife;
         
         
         
         DiplomatieBetreibenSchleife:
         loop
            
            AktionAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Diplomatie_Menü_Enum);
            
            case
              AktionAuswahl
            is
               when RueckgabeDatentypen.Kartenart_Zufall_Enum =>
                  Handeln.SichtbarkeitTauschen (RasseEinsExtern => RasseExtern,
                                                RasseZweiExtern => KontaktierteRasse);
                  
               when RueckgabeDatentypen.Keine_Rasse_Enum =>
                  EinheitVerschieben.VonEigenemLandWerfen (RasseExtern             => RasseExtern,
                                                           KontaktierteRasseExtern => KontaktierteRasse);
                  
               when RueckgabeDatentypen.Schwierigkeitsgrad_Leicht_Enum =>
                  DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                             RasseZweiExtern   => KontaktierteRasse,
                                                                             NeuerStatusExtern => DiplomatieDatentypen.Nichtangriffspakt_Enum);
                  
               when RueckgabeDatentypen.Schwierigkeitsgrad_Mittel_Enum =>
                  DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                             RasseZweiExtern   => KontaktierteRasse,
                                                                             NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
                  
               when RueckgabeDatentypen.Schwierigkeitsgrad_Schwer_Enum =>
                  DiplomatischerZustandAenderbar.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                             RasseZweiExtern   => KontaktierteRasse,
                                                                             NeuerStatusExtern => DiplomatieDatentypen.Krieg_Enum);
                  
               when RueckgabeDatentypen.Hauptmenü_Enum | RueckgabeDatentypen.Zurück_Enum =>
                  exit DiplomatieBetreibenSchleife;
                  
               when RueckgabeDatentypen.Spiel_Beenden_Enum =>
                  return;
                  
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "Diplomatie.Diplomatie - Ungültiger Rückgabewert.");
            end case;
            
         end loop DiplomatieBetreibenSchleife;
         
      end loop DiplomatieSchleife;
      
   end Diplomatie;

end Diplomatie;
