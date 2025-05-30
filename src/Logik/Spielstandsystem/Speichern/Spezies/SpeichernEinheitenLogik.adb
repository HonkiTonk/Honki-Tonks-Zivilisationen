with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with EinheitenRecords;
with EinheitenKonstanten;
with KartenRecords;
with StadtDatentypen;
with KampfDatentypen;
with KIDatentypen;
with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseGrenzen;
with LeseEinheitenDatenbank;

package body SpeichernEinheitenLogik is

   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      VorhandeneEinheiten := EinheitenKonstanten.LeerNummer;
      
      AnzahlEinheitenSchleife:
      for AnzahlEinheitenSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, AnzahlEinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit AnzahlEinheitenSchleife;
               
            when others =>
               VorhandeneEinheiten := AnzahlEinheitenSchleifenwert;
         end case;
         
      end loop AnzahlEinheitenSchleife;
      
      EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
                                                  VorhandeneEinheiten);
      
      case
        VorhandeneEinheiten
      is
         when 0 =>
            return True;
            
         when others =>
            return Einheitenwerte (SpeziesExtern          => SpeziesExtern,
                                   DateiSpeichernExtern   => DateiSpeichernExtern,
                                   EinheitenbereichExtern => VorhandeneEinheiten);
      end case;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernEinheitenLogik.Einheiten: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Einheiten;
   
   
   
   function Einheitenwerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type;
      EinheitenbereichExtern : in EinheitenDatentypen.Einheitenbereich)
      return Boolean
   is
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      Belegung := LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. EinheitenbereichExtern loop
         
         ID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert));
         
         EinheitenDatentypen.EinheitenIDVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                         ID);
                  
         KartenRecords.KartenfeldNaturalRecord'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
                  
         StadtDatentypen.Städtebereich'Write (Stream (File => DateiSpeichernExtern),
                                               LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
                  
         KampfDatentypen.LebenspunkteVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
                  
         EinheitenDatentypen.BewegungspunkteVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                             LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
                  
         KampfDatentypen.Erfahrungspunkte'Write (Stream (File => DateiSpeichernExtern),
                                                 LeseEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
                  
         KampfDatentypen.Rang'Write (Stream (File => DateiSpeichernExtern),
                                     LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
         EinheitenRecords.ArbeitRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseEinheitenGebaut.BeschäftigungSpeichern (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
         EinheitenRecords.ArbeitRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseEinheitenGebaut.BeschäftigungNachfolgerSpeichern (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
         -- Das hier wird auch für die Festlegung der menschlichen Bewegung verwendet, muss also Belegungsunabhängig gespeichert werden.
         KartenRecords.KartenfeldNaturalRecord'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         
         case
           Belegung
         is
            when SpeziesDatentypen.KI_Spieler_Enum =>
               KIDatentypen.Einheit_Aufgabe_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                        LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
               
               KartenRecords.KartenfeldNaturalRecord'Write (Stream (File => DateiSpeichernExtern),
                                                            LeseEinheitenGebaut.KIZielKoordinatenNachfolger (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
               
               KIDatentypen.Einheit_Aufgabe_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                        LeseEinheitenGebaut.KIBeschäftigtNachfolger (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
               
               AufgabenDatentypen.Einheiten_Aufgaben_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                 LeseEinheitenGebaut.KIVerbesserung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
               
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               EinheitenRecords.EinheitMeldungenArray'Write (Stream (File => DateiSpeichernExtern),
                                                             LeseEinheitenGebaut.AlleMeldungen (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         end case;
         
         case
           LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => SpeziesExtern,
                                                      IDExtern      => ID)
         is
            when EinheitenDatentypen.Kein_Transport_Enum =>
               null;
               
            when others =>
               TransportplätzeBelegt := 0;
               
               TransportSchleife:
               for TransportSchleifenwert in EinheitenRecords.TransporterArray'Range loop
                  
                  case
                    LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert),
                                                       PlatzExtern                => TransportSchleifenwert)
                  is
                     when 0 =>
                        null;
                        
                     when others =>
                        TransportplätzeBelegt := TransportplätzeBelegt + 1;
                  end case;
                  
               end loop TransportSchleife;
               
               EinheitenDatentypen.Transportplätze'Write (Stream (File => DateiSpeichernExtern),
                                                           TransportplätzeBelegt);
               
               LadungSchleife:
               for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. TransportplätzeBelegt loop
                  
                  GeladeneEinheit := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert),
                                                                        PlatzExtern                => LadungSchleifenwert);
                  
                  case
                    GeladeneEinheit
                  is
                     when 0 =>
                        MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernEinheitenLogik.Einheitenwerte: Geladene Einheit ist leer");
                        return False;
                        
                     when others =>
                        EinheitenDatentypen.EinheitenbereichVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                                             GeladeneEinheit);
                  end case;
                  
               end loop LadungSchleife;
         end case;
         
         case
           LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                           IDExtern      => ID)
         is
            when EinheitenDatentypen.Kein_Transport_Enum =>
               null;
               
            when others =>
               EinheitenDatentypen.Einheitenbereich'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert)));
         end case;
         
      end loop EinheitenSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernEinheitenLogik.Einheitenwerte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Einheitenwerte;

end SpeichernEinheitenLogik;
