pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with InteraktionAuswahl;
with GrafikDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;
with MenueDatentypen;

with NachGrafiktask;
with TasteneingabeLogik;
with MausauswahlLogik;
with AuswahlaufteilungLogik;
with Fehler;
with DiplomatischerZustandAenderbarLogik;
with EinheitenverschiebungLogik;
with HandelnLogik;

package body DiplomatieLogik is
   
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
             SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Leer_Spieler_Enum
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
            
            Auswahl := MausauswahlLogik.RassenauswahlDiplomatie;
            NachGrafiktask.AktuelleAuswahl.AuswahlEins := Auswahl;
                        
            case
              TasteneingabeLogik.VereinfachteEingabe
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
               
               when TastenbelegungDatentypen.Abwählen_Enum =>
                  return;
               
               when others =>
                  null;
            end case;
            
         end loop RassenauswahlSchleife;
         
         
         
         DiplomatieBetreibenSchleife:
         loop
            
            AktionAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Diplomatie_Menü_Enum);
            
            case
              AktionAuswahl
            is
               when RueckgabeDatentypen.Auswahl_Eins_Enum =>
                  HandelnLogik.SichtbarkeitTauschen (RasseEinsExtern => RasseExtern,
                                                     RasseZweiExtern => KontaktierteRasse);
                  
               when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
                  EinheitenverschiebungLogik.VonEigenemLandWerfen (RasseExtern             => RasseExtern,
                                                                   KontaktierteRasseExtern => KontaktierteRasse);
                  
               when RueckgabeDatentypen.Auswahl_Drei_Enum =>
                  DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                  RasseZweiExtern   => KontaktierteRasse,
                                                                                  NeuerStatusExtern => DiplomatieDatentypen.Nichtangriffspakt_Enum);
                  
               when RueckgabeDatentypen.Auswahl_Vier_Enum =>
                  DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                  RasseZweiExtern   => KontaktierteRasse,
                                                                                  NeuerStatusExtern => DiplomatieDatentypen.Neutral_Enum);
                  
               when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
                  DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (RasseEinsExtern   => RasseExtern,
                                                                                  RasseZweiExtern   => KontaktierteRasse,
                                                                                  NeuerStatusExtern => DiplomatieDatentypen.Krieg_Enum);
                  
               when RueckgabeDatentypen.Hauptmenü_Enum | RueckgabeDatentypen.Zurück_Enum =>
                  exit DiplomatieBetreibenSchleife;
                  
               when RueckgabeDatentypen.Spiel_Beenden_Enum =>
                  return;
                  
               when others =>
                  Fehler.LogikFehler (FehlermeldungExtern => "Diplomatie.Diplomatie: Ungültige Rückgabe: " & AktionAuswahl'Wide_Wide_Image);
            end case;
            
         end loop DiplomatieBetreibenSchleife;
         
      end loop DiplomatieSchleife;
      
   end Diplomatie;

end DiplomatieLogik;
