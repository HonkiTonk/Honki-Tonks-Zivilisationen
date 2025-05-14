with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenRecords;
with SpielRecords;
with ZahlenDatentypen;
with ProduktionDatentypen;
with StadtDatentypen;
with EinheitenDatentypen;
with ForschungKonstanten;
with ForschungenDatentypen;

with LeseWichtiges;
with LeseGrenzen;
with LeseZeiger;

package body SpeichernSpezienspezifischesLogik is
   
   function Aufteilung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        Grenzen (SpeziesExtern        => SpeziesExtern,
                 DateiSpeichernExtern => DateiSpeichernExtern)
      is
         when False =>
            return False;
            
         when True =>
            return Wichtiges (SpeziesExtern        => SpeziesExtern,
                              DateiSpeichernExtern => DateiSpeichernExtern);
      end case;
      
   end Aufteilung;
   
   

   function Grenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
   
      SpielRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSpezienspezifischesLogik.Grenzen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Grenzen;
   
   
   
   function Wichtiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.VierByte;
   begin
      
      ZahlenDatentypen.EigenerInteger'Write (Stream (File => DateiSpeichernExtern),
                                             LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern));
      
      -- Das hier, und eventuell auch andere Sachen, weglassen und einfach neu berechnen nach dem Laden? äöü
      ProduktionDatentypen.Produktion'Write (Stream (File => DateiSpeichernExtern),
                                             LeseWichtiges.GeldRundengewinn (SpeziesExtern => SpeziesExtern));
      
      -- Das hier, und eventuell auch andere Sachen, weglassen und einfach neu berechnen nach dem Laden? äöü
      ProduktionDatentypen.Lagermenge'Write (Stream (File => DateiSpeichernExtern),
                                             LeseWichtiges.GesamteForschungsrate (SpeziesExtern => SpeziesExtern));
      
      ProduktionDatentypen.Lagermenge'Write (Stream (File => DateiSpeichernExtern),
                                             LeseWichtiges.Forschungsmenge (SpeziesExtern => SpeziesExtern));
      
      -- Das hier, und eventuell auch andere Sachen, weglassen und einfach neu berechnen nach dem Laden? äöü
      ProduktionDatentypen.Lagermenge'Write (Stream (File => DateiSpeichernExtern),
                                             LeseWichtiges.VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern));
      
      ForschungenDatentypen.ForschungID'Write (Stream (File => DateiSpeichernExtern),
                                               LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern));
      
      -- Solle sich die Anzahl der Forschungen nicht zu weit erhöhen könnte man das auch als 2 statt 4 Bytes speichern und noch einmal 2 Byte pro Speicherung sparen.
      BereichSchleife:
      for BereichSchleifenwert in ForschungKonstanten.ForschungsbereichArray'Range loop
      
         ForschungVorhanden := 0;
         AktuellerForschungswert := 1;
         
         ForschungSchleife:
         for ForschungSchleifenwert in ForschungKonstanten.Forschunganfang (BereichSchleifenwert) .. ForschungKonstanten.Forschungsende (BereichSchleifenwert) loop
         
            case
              LeseWichtiges.Erforscht (SpeziesExtern           => SpeziesExtern,
                                       WelcheTechnologieExtern => ForschungSchleifenwert)
            is
               when True =>
                  ForschungVorhanden := ForschungVorhanden + AktuellerForschungswert;
               
               when False =>
                  null;
            end case;
         
            AktuellerForschungswert := AktuellerForschungswert * 2;
         
         end loop ForschungSchleife;
         
         SystemDatentypenHTSEB.VierByte'Write (Stream (File => DateiSpeichernExtern),
                                          ForschungVorhanden);
         
      end loop BereichSchleife;
      
      -- Sind diese vier Werte für menschliche Spieler überhaupt relevant? äöü
      StadtDatentypen.Städtebereich'Write (Stream (File => DateiSpeichernExtern),
                                            LeseWichtiges.AnzahlStädte (SpeziesExtern => SpeziesExtern));
      
      EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
                                                  LeseWichtiges.AnzahlArbeiter (SpeziesExtern => SpeziesExtern));
      
      EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
                                                  LeseWichtiges.AnzahlKämpfer (SpeziesExtern => SpeziesExtern));
      
      EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
                                                  LeseWichtiges.AnzahlSonstiges (SpeziesExtern => SpeziesExtern));
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            KartenRecords.ZeigerRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseZeiger.GanzerEintrag (SpeziesExtern => SpeziesExtern));
            
         when others =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSpezienspezifischesLogik.Wichtiges: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Wichtiges;

end SpeichernSpezienspezifischesLogik;
