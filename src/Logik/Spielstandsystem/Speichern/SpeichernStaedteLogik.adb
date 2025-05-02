with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with StadtRecords;
with StadtKonstanten;
with KartenverbesserungDatentypen;
with ProduktionDatentypen;
with KIDatentypen;
with KartenRecords;

with LeseStadtGebaut;
with LeseGrenzen;

package body SpeichernStaedteLogik is

   function Städte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      VorhandeneStädte := StadtKonstanten.LeerNummer;
      
      AnzahlStädteSchleife:
      for AnzahlStädteSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop

         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, AnzahlStädteSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit AnzahlStädteSchleife;
               
            when others =>
               VorhandeneStädte := AnzahlStädteSchleifenwert;
         end case;

      end loop AnzahlStädteSchleife;
      
      StadtDatentypen.Städtebereich'Write (Stream (File => DateiSpeichernExtern),
                                            VorhandeneStädte);
      
      Belegung := LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. VorhandeneStädte loop
                           
         KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                       LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         KartenRecords.KartenfeldNaturalRecord'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         StadtRecords.EinwohnerArbeiterArray'Write (Stream (File => DateiSpeichernExtern),
                                                    (LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                                                        EinwohnerArbeiterExtern  => True),
                                                     LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                                                        EinwohnerArbeiterExtern  => False)));
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                     LeseStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.StadtLagermenge'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseStadtGebaut.Material (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         PermanenteKostenSchleife:
         for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
            ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                        LeseStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                                                                WelcherPostenExtern      => PermanenteKostenSchleifenwert));
            
         end loop PermanenteKostenSchleife;
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                     LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         StadtRecords.BauprojektRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.Produktion'Write (Stream (File => DateiSpeichernExtern),
                                                LeseStadtGebaut.Bauzeit (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                     LeseStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.Stadtproduktion'Write (Stream (File => DateiSpeichernExtern),
                                                     LeseStadtGebaut.Korruption (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         ProduktionDatentypen.ZufriedenheitVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                            LeseStadtGebaut.Zufriedenheit (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         AktuellesGebäude := 1;
         VorhandeneGebäude := 0;
         
         GebäudeSchleife:
         for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
            
            case
              LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                 WelchesGebäudeExtern     => GebäudeSchleifenwert)
            is
               when True =>
                  VorhandeneGebäude := VorhandeneGebäude + AktuellesGebäude;
                  
               when False =>
                  null;
            end case;
            
            AktuellesGebäude := AktuellesGebäude * 2;
            
         end loop GebäudeSchleife;
         
         Natural'Write (Stream (File => DateiSpeichernExtern),
                        VorhandeneGebäude);
         
         Unbounded_Wide_Wide_String'Write (Stream (File => DateiSpeichernExtern),
                                           LeseStadtGebaut.Name (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));

         AktuelleBewirtschaftung := 1;
         VorhandeneBewirtschaftung := 0;
         
         SenkrechteBewirtschaftungSchleife:
         for SenkrechteBewirtschaftungSchleifenwert in StadtRecords.UmgebungBewirtschaftungArray'First (1) .. 0 loop
            WaagerechteBewirtschaftungSchleife:
            for WaagerechteBewirtschaftungSchleifenwert in StadtRecords.UmgebungBewirtschaftungArray'Range (2) loop
               
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                          YKoordinateExtern        => SenkrechteBewirtschaftungSchleifenwert,
                                                          XKoordinateExtern        => WaagerechteBewirtschaftungSchleifenwert)
               is
                  when True =>
                     VorhandeneBewirtschaftung := VorhandeneBewirtschaftung + AktuelleBewirtschaftung;
                  
                  when False =>
                     null;
               end case;
               
               AktuelleBewirtschaftung := AktuelleBewirtschaftung * 2;
               
            end loop WaagerechteBewirtschaftungSchleife;
         end loop SenkrechteBewirtschaftungSchleife;
         
         Natural'Write (Stream (File => DateiSpeichernExtern),
                        VorhandeneBewirtschaftung);
         
         AktuelleBewirtschaftung := 1;
         VorhandeneBewirtschaftung := 0;
         
         SenkrechteBewirtschaftungZweiSchleife:
         for SenkrechteBewirtschaftungSchleifenwert in 1 .. StadtRecords.UmgebungBewirtschaftungArray'Last (1) loop
            WaagerechteBewirtschaftungZweiSchleife:
            for WaagerechteBewirtschaftungSchleifenwert in StadtRecords.UmgebungBewirtschaftungArray'Range (2) loop
               
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                          YKoordinateExtern        => SenkrechteBewirtschaftungSchleifenwert,
                                                          XKoordinateExtern        => WaagerechteBewirtschaftungSchleifenwert)
               is
                  when True =>
                     VorhandeneBewirtschaftung := VorhandeneBewirtschaftung + AktuelleBewirtschaftung;
                  
                  when False =>
                     null;
               end case;
               
               AktuelleBewirtschaftung := AktuelleBewirtschaftung * 2;
               
            end loop WaagerechteBewirtschaftungZweiSchleife;
         end loop SenkrechteBewirtschaftungZweiSchleife;
         
         Natural'Write (Stream (File => DateiSpeichernExtern),
                        VorhandeneBewirtschaftung);
         
         KartenRecords.UmgebungDreiRecord'Write (Stream (File => DateiSpeichernExtern),
                                                 LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         
         case
           Belegung
         is
            when SpeziesDatentypen.Mensch_Spieler_Enum =>
               MeldungenSchleife:
               for MeldungenSchleifenwert in StadtRecords.StadtMeldungenArray'Range loop
            
                  StadtDatentypen.Stadt_Meldung_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                            LeseStadtGebaut.Meldungen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                                                       WelcheMeldungExtern      => MeldungenSchleifenwert));
            
               end loop MeldungenSchleife;
               
            when SpeziesDatentypen.KI_Spieler_Enum =>
               KIDatentypen.Stadt_Aufgabe_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)));
         end case;
            
      end loop StadtSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernStaedteLogik.Städte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Städte;

end SpeichernStaedteLogik;
