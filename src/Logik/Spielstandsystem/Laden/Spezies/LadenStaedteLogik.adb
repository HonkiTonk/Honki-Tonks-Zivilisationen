with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with StadtKonstanten;

with SchreibeStadtGebaut;

with SpielstandAllgemeinesLogik;

package body LadenStaedteLogik is

   function Städte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      StadtDatentypen.Städtebereich'Read (Stream (File => DateiLadenExtern),
                                           VorhandeneStädte);
      
      case
        VorhandeneStädte
      is
         when 0 =>
            return True;
            
         when others =>
            Belegung := SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesExtern);
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. VorhandeneStädte loop
         
         case
           Stadtwerte (LadenPrüfenExtern => LadenPrüfenExtern,
                       SpeziesExtern     => SpeziesExtern,
                       BelegungExtern    => Belegung,
                       DateiLadenExtern  => DateiLadenExtern,
                       StadtExtern       => StadtSchleifenwert)
         is
            when False =>
               return False;
               
            when True =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenStaedteLogik.Städte: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Städte;
   
   
   
   function Stadtwerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      BelegungExtern : in SpeziesDatentypen.Spieler_Belegt_Enum;
      DateiLadenExtern : in File_Type;
      StadtExtern : in StadtDatentypen.StädtebereichVorhanden)
      return Boolean
   is
      use type SpeziesDatentypen.Spieler_Enum;
      use type SystemDatentypenHTSEB.VierByte;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Read (Stream (File => DateiLadenExtern),
                                                                   ID);
         
      KartenRecords.KartenfeldNaturalRecord'Read (Stream (File => DateiLadenExtern),
                                                  Koordinaten);
         
      StadtRecords.EinwohnerArbeiterArray'Read (Stream (File => DateiLadenExtern),
                                                EinwohnerArbeiter);
         
      ProduktionDatentypen.Stadtproduktion'Read (Stream (File => DateiLadenExtern),
                                                 Nahrungsmittel);
         
      ProduktionDatentypen.Stadtproduktion'Read (Stream (File => DateiLadenExtern),
                                                 Nahrungsproduktion);
         
      ProduktionDatentypen.StadtLagermenge'Read (Stream (File => DateiLadenExtern),
                                                 Material);
         
      ProduktionDatentypen.Stadtproduktion'Read (Stream (File => DateiLadenExtern),
                                                 Produktionrate);
         
      ProduktionDatentypen.Stadtproduktion'Read (Stream (File => DateiLadenExtern),
                                                 Geldgewinnung);
         
      StadtRecords.PermanenteKostenArray'Read (Stream (File => DateiLadenExtern),
                                               AlleKostenposten);
         
      ProduktionDatentypen.Stadtproduktion'Read (Stream (File => DateiLadenExtern),
                                                 Forschungsrate);
         
      StadtRecords.BauprojektRecord'Read (Stream (File => DateiLadenExtern),
                                          Bauprojekt);
         
      ProduktionDatentypen.Produktion'Read (Stream (File => DateiLadenExtern),
                                            Bauzeit);
         
      ProduktionDatentypen.Stadtproduktion'Read (Stream (File => DateiLadenExtern),
                                                 Korruption);
         
      ProduktionDatentypen.ZufriedenheitVorhanden'Read (Stream (File => DateiLadenExtern),
                                                        Zufriedenheit);
            
      SystemDatentypenHTSEB.VierByte'Read (Stream (File => DateiLadenExtern),
                                           Gebäude);
      
      Potenz := Positive (StadtDatentypen.GebäudeIDVorhanden'Last);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in reverse StadtDatentypen.GebäudeIDVorhanden'Range loop
                     
         Potenz := Potenz - 1;
         
         if
           Gebäude >= 2**Potenz
         then
            VorhandeneGebäude (GebäudeSchleifenwert) := True;
            Gebäude := Gebäude - 2**Potenz;
                  
         else
            VorhandeneGebäude (GebäudeSchleifenwert) := False;
         end if;
         
      end loop GebäudeSchleife;
                  
      Unbounded_Wide_Wide_String'Read (Stream (File => DateiLadenExtern),
                                       Stadtname);
            
      SenkrechteBewirtschaftungSchleife:
      for SenkrechteBewirtschaftungSchleifenwert in StadtRecords.UmgebungBewirtschaftungArray'Range (1) loop

         SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                             Bewirtschaftung);
         
         Potenz := StadtRecords.UmgebungBewirtschaftungArray'Length (2);
         
         WaagerechteBewirtschaftungSchleife:
         for WaagerechteBewirtschaftungSchleifenwert in reverse StadtRecords.UmgebungBewirtschaftungArray'Range (2) loop
               
            Potenz := Potenz - 1;
            
            if
              Bewirtschaftung >= 2**Potenz
            then
               Bewirtschaftungsbelegung (SenkrechteBewirtschaftungSchleifenwert, WaagerechteBewirtschaftungSchleifenwert) := True;
               Bewirtschaftung := Bewirtschaftung - 2**Potenz;
                  
            else
               Bewirtschaftungsbelegung (SenkrechteBewirtschaftungSchleifenwert, WaagerechteBewirtschaftungSchleifenwert) := False;
            end if;
               
         end loop WaagerechteBewirtschaftungSchleife;
      end loop SenkrechteBewirtschaftungSchleife;
      
      KartenRecords.UmgebungDreiRecord'Read (Stream (File => DateiLadenExtern),
                                             Gesamtumgebung);
      
      case
        BelegungExtern
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            StadtRecords.StadtMeldungenArray'Read (Stream (File => DateiLadenExtern),
                                                   Meldungen);
            
         when SpeziesDatentypen.KI_Spieler_Enum =>
            KIDatentypen.Stadt_Aufgabe_Enum'Read (Stream (File => DateiLadenExtern),
                                                  KIBeschäftigung);
      end case;
         
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeStadtGebaut.IDKoordinatenLaden (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                    IDExtern                 => ID,
                                                    KoordinatenExtern        => Koordinaten);
            
            SchreibeStadtGebaut.EinwohnerArbeiterLaden (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                        EinwohnerArbeiterExtern  => EinwohnerArbeiter);
            
            SchreibeStadtGebaut.Nahrungsmittel (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                NahrungsmittelExtern     => Nahrungsmittel,
                                                ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                    NahrungsproduktionExtern => Nahrungsproduktion,
                                                    ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                          MaterialExtern           => Material,
                                          ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                ProduktionrateExtern     => Produktionrate,
                                                ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.Geldgewinnung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                               GeldgewinnungExtern      => Geldgewinnung,
                                               ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.AlleKostenposten (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                  AlleKostenpostenExtern   => AlleKostenposten);
            
            SchreibeStadtGebaut.Forschungsrate (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                ForschungsrateExtern     => Forschungsrate,
                                                ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                            BauprojektExtern         => Bauprojekt);
            
            SchreibeStadtGebaut.Bauzeit (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern));
            
            SchreibeStadtGebaut.Korruption (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                            KorruptionExtern         => Korruption,
                                            ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.Zufriedenheit (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                               ZufriedenheitExtern      => Zufriedenheit,
                                               ÄndernSetzenExtern       => False);
            
            SchreibeStadtGebaut.AlleGebäude (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                              GebäudeExtern            => VorhandeneGebäude);
            
            SchreibeStadtGebaut.Name (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                      NameExtern               => Stadtname);
            
            SchreibeStadtGebaut.GesamteBewirtschaftung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                        BewirtschaftungExtern    => Bewirtschaftungsbelegung);
            
            SchreibeStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                UmgebungGrößeExtern      => Gesamtumgebung,
                                                ÄndernSetzenExtern       => False);
            
            if
              BelegungExtern = SpeziesDatentypen.Mensch_Spieler_Enum
            then
               SchreibeStadtGebaut.AlleMeldungen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                  MeldungenExtern          => Meldungen);
            
            else
               SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtExtern),
                                                     BeschäftigungExtern      => KIBeschäftigung);
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenStaedteLogik.Stadtwerte: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Stadtwerte;

end LadenStaedteLogik;
