with InteraktionAuswahl;
with GrafikDatentypen;
with TastenbelegungDatentypen;
with MenueDatentypen;
with AuswahlKonstanten;

with LeseDiplomatie;
with SchreibeDiplomatie;
with LeseAllgemeines;

with NachGrafiktask;
with TasteneingabeLogik;
with MausauswahlLogik;
with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with DiplomatischerZustandAenderbarLogik;
with EinheitenverschiebungLogik;
with HandelnLogik;

package body DiplomatieLogik is
   
   procedure DiplomatieMöglich
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Speziesprüfungen (SpeziesExtern => SpeziesExtern);
      Diplomatie (SpeziesExtern => SpeziesExtern);
      
   end DiplomatieMöglich;
   
   
   
   procedure Speziesprüfungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            InteraktionAuswahl.SpeziesMöglich (SpeziesSchleifenwert) := False;
            
         elsif
           DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                                  SpeziesZweiExtern => SpeziesSchleifenwert)
         then
            InteraktionAuswahl.SpeziesMöglich (SpeziesSchleifenwert) := False;
            
         else
            InteraktionAuswahl.SpeziesMöglich (SpeziesSchleifenwert) := True;
         end if;
         
      end loop SpeziesSchleife;
      
   end Speziesprüfungen;
   
   
   
   procedure Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      DiplomatieSchleife:
      loop
         
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Diplomatie_Enum;
         
         SpeziesauswahlSchleife:
         loop
            
            Auswahl := MausauswahlLogik.SpeziesauswahlDiplomatie;
            NachGrafiktask.AktuelleAuswahl.AuswahlEins := Auswahl;
                        
            case
              TasteneingabeLogik.VereinfachteEingabe
            is
               when TastenbelegungDatentypen.Auswählen_Enum =>
                  if
                    Auswahl = AuswahlKonstanten.LeerAuswahl
                  then
                     null;
                  
                  else
                     KontaktierteSpezies := SpeziesDatentypen.Spezies_Verwendet_Enum'Val (Auswahl);
                     NachGrafiktask.KontaktierteSpezies := KontaktierteSpezies;
                     exit SpeziesauswahlSchleife;
                  end if;
               
               when TastenbelegungDatentypen.Abwählen_Enum =>
                  return;
               
               when others =>
                  null;
            end case;
            
         end loop SpeziesauswahlSchleife;
         
         
         
         DiplomatieBetreibenSchleife:
         loop
            
            AktionAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Diplomatie_Menü_Enum);
            
            case
              AktionAuswahl
            is
               when RueckgabeDatentypen.Auswahl_Eins_Enum =>
                  HandelnLogik.SichtbarkeitTauschen (SpeziesEinsExtern => SpeziesExtern,
                                                     SpeziesZweiExtern => KontaktierteSpezies);
                  
               when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
                  EinheitenverschiebungLogik.VonEigenemLandWerfen (SpeziesExtern             => SpeziesExtern,
                                                                   KontaktierteSpeziesExtern => KontaktierteSpezies);
                  
               when RueckgabeDatentypen.Auswahl_Drei_Enum =>
                  DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (SpeziesEinsExtern                   => SpeziesExtern,
                                                                                  SpeziesZweiExtern                   => KontaktierteSpezies,
                                                                                  NeuerStatusExtern                   => DiplomatieDatentypen.Nichtangriffspakt_Enum,
                                                                                  ZeitbegrenzungBerücksichtigenExtern => True);
                  
               when RueckgabeDatentypen.Auswahl_Vier_Enum =>
                  DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (SpeziesEinsExtern                   => SpeziesExtern,
                                                                                  SpeziesZweiExtern                   => KontaktierteSpezies,
                                                                                  NeuerStatusExtern                   => DiplomatieDatentypen.Neutral_Enum,
                                                                                  ZeitbegrenzungBerücksichtigenExtern => True);
                  
               when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
                  DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (SpeziesEinsExtern                   => SpeziesExtern,
                                                                                  SpeziesZweiExtern                   => KontaktierteSpezies,
                                                                                  NeuerStatusExtern                   => DiplomatieDatentypen.Krieg_Enum,
                                                                                  ZeitbegrenzungBerücksichtigenExtern => True);
                  
               when RueckgabeDatentypen.Hauptmenü_Enum | RueckgabeDatentypen.Zurück_Enum =>
                  exit DiplomatieBetreibenSchleife;
                  
               when RueckgabeDatentypen.Spiel_Beenden_Enum =>
                  return;
                  
               when others =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "DiplomatieLogik.Diplomatie: Ungültige Rückgabe: " & AktionAuswahl'Wide_Wide_Image);
            end case;
            
         end loop DiplomatieBetreibenSchleife;
         
      end loop DiplomatieSchleife;
      
   end Diplomatie;
   
   
   
   procedure DiplomatieRundenende
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
            
         if
           SpeziesExtern = SpeziesSchleifenwert
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                                  SpeziesZweiExtern => SpeziesSchleifenwert)
         then
            null;
            
         else
            SchreibeDiplomatie.ZeitSeitÄnderung (SpeziesEinsExtern    => SpeziesExtern,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  ÄnderungExtern      => 1,
                                                  RechnenSetzenExtern => True);
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => SpeziesExtern,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => SchwierigkeitsgradMeinungsverbesserung (LeseAllgemeines.Schwierigkeitsgrad),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end DiplomatieRundenende;

end DiplomatieLogik;
