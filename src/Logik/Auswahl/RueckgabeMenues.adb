pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GlobaleVariablen;

with Fehler;

package body RueckgabeMenues is
   
   function RückgabeMenüs
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Vorhanden_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü_Enum =>
            return Hauptmenü (AnfangExtern          => AnfangExtern,
                               EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Spiel_Menü_Enum =>
            return Spielmenü (AnfangExtern          => AnfangExtern,
                               EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Optionen_Menü_Enum =>
            return Optionsmenü (AnfangExtern          => AnfangExtern,
                                 EndeExtern            => EndeExtern,
                                 AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartengröße_Menü_Enum =>
            return KartengrößeAuswählen (AnfangExtern          => AnfangExtern,
                                            EndeExtern            => EndeExtern,
                                            AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartenart_Menü_Enum =>
            return KartenartAuswählen (AnfangExtern          => AnfangExtern,
                                        EndeExtern            => EndeExtern,
                                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartenform_Menü_Enum =>
            return KartenformAuswählen (AnfangExtern          => AnfangExtern,
                                         EndeExtern            => EndeExtern,
                                         AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartentemperatur_Menü_Enum =>
            return KartentemperaturAuswählen (AnfangExtern          => AnfangExtern,
                                               EndeExtern            => EndeExtern,
                                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartenressourcen_Menü_Enum =>
            return KartenRessourcenAuswählen (AnfangExtern          => AnfangExtern,
                                               EndeExtern            => EndeExtern,
                                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü_Enum =>
            return SchwierigkeitsgradAuswählen (AnfangExtern          => AnfangExtern,
                                                 EndeExtern            => EndeExtern,
                                                 AktuelleAuswahlExtern => AktuelleAuswahlExtern);
                        
         when SystemDatentypen.Rassen_Menü_Enum =>
            return RasseAuswählen (AnfangExtern          => AnfangExtern,
                                    EndeExtern            => EndeExtern,
                                    AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Grafik_Menü_Enum =>
            return GrafikMenü (AnfangExtern          => AnfangExtern,
                                EndeExtern            => EndeExtern,
                                AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Sound_Menü_Enum =>
            return SoundMenü (AnfangExtern          => AnfangExtern,
                               EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Steuerung_Menü_Enum =>
            return SteuerungMenü (EndeExtern            => EndeExtern,
                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Sonstiges_Menü_Enum =>
            return SonstigesMenü (AnfangExtern          => AnfangExtern,
                                   EndeExtern            => EndeExtern,
                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
               
         when SystemDatentypen.Editoren_Menü_Enum =>
            return EditorenMenü (AnfangExtern          => AnfangExtern,
                                  EndeExtern            => EndeExtern,
                                  AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Einstellungen_Menü_Enum =>
            return SpieleinstellungenMenü (AnfangExtern          => AnfangExtern,
                                            EndeExtern            => EndeExtern,
                                            AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end case;
      
   end RückgabeMenüs;
   
   

   -- Theoretisch müsste ZurückHauptmenüBeenden hier auch funktionieren.
   function Hauptmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
                  
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Laden_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Optionen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Editoren_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Würdigungen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.Hauptmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end Hauptmenü;
   
   
   
   -- Theoretisch müsste ZurückHauptmenüBeenden hier auch funktionieren.
   function Spielmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Start_Weiter_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Speichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Laden_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Optionen_Enum;
                    
      else
         return HauptmenüEnde (EndeExtern            => EndeExtern,
                                AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end Spielmenü;
   
   
   
   function Optionsmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Grafik_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Sound_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Steuerung_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Sonstiges_Enum;
                    
      else
         return HauptmenüEnde (EndeExtern            => EndeExtern,
                                AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end Optionsmenü;
   
   
   
   function SpieleinstellungenMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Auswahl_Kartengröße_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Auswahl_Kartenart_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Auswahl_Kartenform_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Auswahl_Kartentemperatur_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Auswahl_Kartenressourcen_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Auswahl_Rassen_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return RueckgabeDatentypen.Auswahl_Schwierigkeitsgrad_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return RueckgabeDatentypen.Fertig_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return RueckgabeDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.SpieleinstellungenMenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end SpieleinstellungenMenü;
   
   
      
   function KartengrößeAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Karte_Größe_20_20_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Karte_Größe_40_40_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Karte_Größe_80_80_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Karte_Größe_120_80_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Karte_Größe_120_160_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Karte_Größe_160_160_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return RueckgabeDatentypen.Karte_Größe_240_240_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return RueckgabeDatentypen.Karte_Größe_320_320_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return RueckgabeDatentypen.Karte_Größe_1000_1000_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return RueckgabeDatentypen.Karte_Größe_Nutzer_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return RueckgabeDatentypen.Karte_Größe_Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartengrößeAuswählen;
   
   
   
   function KartenartAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Karte_Art_Inseln_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Karte_Art_Kontinente_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Karte_Art_Pangäa_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Karte_Art_Nur_Land_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Karte_Art_Chaos_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartenartAuswählen;
   
   
   
   function KartenformAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Karte_Form_X_Zylinder_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Karte_Form_Y_Zylinder_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Karte_Form_Torus_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Karte_Form_Kugel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Karte_Form_Viereck_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Karte_Form_Kugel_Gedreht_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return RueckgabeDatentypen.Karte_Form_Tugel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return RueckgabeDatentypen.Karte_Form_Tugel_Gedreht_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return RueckgabeDatentypen.Karte_Form_Tugel_Extrem_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartenformAuswählen;
   
   
   
   function KartentemperaturAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Karte_Temperatur_Kalt_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Karte_Temperatur_Gemäßigt_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Karte_Temperatur_Heiß_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Karte_Temperatur_Eiszeit_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Karte_Temperatur_Wüste_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartentemperaturAuswählen;
   
   
   
   function KartenRessourcenAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Karte_Ressource_Arm_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Karte_Ressource_Wenig_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Karte_Ressource_Mittel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Karte_Ressource_Viel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Karte_Ressource_Überfluss_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartenRessourcenAuswählen;
   
   
   
   function SchwierigkeitsgradAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Schwierigkeit_Leicht_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Schwierigkeit_Mittel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Schwierigkeit_Schwer_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end SchwierigkeitsgradAuswählen;
   
   
   
   function RasseAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Menschen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Kasrodiah_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Lasupin_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Lamustra_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Manuky_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return RueckgabeDatentypen.Suroka_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return RueckgabeDatentypen.Pryolon_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return RueckgabeDatentypen.Talbidahr_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return RueckgabeDatentypen.Moru_Phisihl_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return RueckgabeDatentypen.Larinos_Lotaris_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return RueckgabeDatentypen.Carupex_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return RueckgabeDatentypen.Alary_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 12
      then
         return RueckgabeDatentypen.Tesorahn_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 13
      then
         return RueckgabeDatentypen.Natries_Zermanis_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 14
      then
         return RueckgabeDatentypen.Tridatus_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 15
      then
         return RueckgabeDatentypen.Senelari_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 16
      then
         return RueckgabeDatentypen.Aspari_2_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 17
      then
         return RueckgabeDatentypen.Ekropa_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 18
      then
         return RueckgabeDatentypen.Zufall_Enum;
                    
      else
         return Fertig (EndeExtern            => EndeExtern,
                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end RasseAuswählen;
   
   
   
   function GrafikMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Auflösung_Ändern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Vollbild_Fenster_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Bildrate_Ändern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Speichern_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end GrafikMenü;
   
   
   
   function SoundMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         null;
         
      else
         null;
      end if;
      
      return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                    AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      
   end SoundMenü;
   
   
   
   function SteuerungMenü
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern - 4
      then
         return RueckgabeDatentypen.Speichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 3
      then
         return RueckgabeDatentypen.Wiederherstellen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return RueckgabeDatentypen.Zurück_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return RueckgabeDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
      else
         GlobaleVariablen.UmbelegungNummer := AktuelleAuswahlExtern;
         return RueckgabeDatentypen.Eingabe_Enum;
      end if;
      
   end SteuerungMenü;
   
   
            
   function SonstigesMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Anzahl_Speicherstände_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Runden_Bis_Autospeichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Sprache_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end SonstigesMenü;
   
   
   
   function EditorenMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return RueckgabeDatentypen.Kartenfeld_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return RueckgabeDatentypen.Einheiten_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return RueckgabeDatentypen.Gebäude_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return RueckgabeDatentypen.Forschung_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return RueckgabeDatentypen.Verbesserungen_Editor_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
      -- return RueckgabeDatentypen.Editoren_Enum;
      
   end EditorenMenü;
   
   
   
   function Fertig
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Fertig_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.Fertig - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end Fertig;
   
   
   
   function HauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return RueckgabeDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.ZurückHauptmenüEnde - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end HauptmenüEnde;
        
   
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
         return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
         
      if
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return RueckgabeDatentypen.Zurück_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return RueckgabeDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.ZurückHauptmenüEnde - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return RueckgabeDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end ZurückHauptmenüEnde;

end RueckgabeMenues;
