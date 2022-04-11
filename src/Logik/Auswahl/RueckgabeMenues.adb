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
      return SystemDatentypen.Rückgabe_Werte_Enum
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
            ------------------------- Hier noch das Zeug einbauen.
            raise Program_Error;
      end case;
      
   end RückgabeMenüs;
   
   

   -- Theoretisch müsste ZurückHauptmenüBeenden hier auch funktionieren.
   function Hauptmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
            
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Start_Weiter_Enum;
                  
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Laden_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Optionen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Editoren_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Würdigungen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.Hauptmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end Hauptmenü;
   
   
   
   -- Theoretisch müsste ZurückHauptmenüBeenden hier auch funktionieren.
   function Spielmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Start_Weiter_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Speichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Laden_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Optionen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.Spielmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end Spielmenü;
   
   
   
   function Optionsmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Grafik_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Sound_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Steuerung_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Sonstiges_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end Optionsmenü;
   
   
      
   function KartengrößeAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Karte_Größe_20_20_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Größe_40_40_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Größe_80_80_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Größe_120_80_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Größe_120_160_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Karte_Größe_160_160_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Karte_Größe_240_240_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Karte_Größe_320_320_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemDatentypen.Karte_Größe_1000_1000_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemDatentypen.Karte_Größe_Nutzer_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemDatentypen.Zufall_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return SystemDatentypen.Karte_Größe_Zufall_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartengrößeAuswählen;
   
   
   
   function KartenartAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Karte_Art_Inseln_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Art_Kontinente_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Art_Pangäa_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Art_Nur_Land_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Art_Chaos_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zufall_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartenartAuswählen;
   
   
   
   function KartenformAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Karte_Form_X_Zylinder_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Form_Y_Zylinder_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Form_Torus_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Form_Kugel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Form_Viereck_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Karte_Form_Kugel_Gedreht_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Karte_Form_Tugel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Karte_Form_Tugel_Gedreht_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemDatentypen.Karte_Form_Tugel_Extrem_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemDatentypen.Zufall_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartenformAuswählen;
   
   
   
   function KartentemperaturAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Karte_Temperatur_Kalt_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Temperatur_Gemäßigt_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Temperatur_Heiß_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Temperatur_Eiszeit_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Temperatur_Wüste_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zufall_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartentemperaturAuswählen;
   
   
   
   function KartenRessourcenAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Karte_Ressource_Arm_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Ressource_Wenig_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Ressource_Mittel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Ressource_Viel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Ressource_Überfluss_Enum;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zufall_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end KartenRessourcenAuswählen;
   
   
   
   function SchwierigkeitsgradAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Schwierigkeit_Leicht_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Schwierigkeit_Mittel_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Schwierigkeit_Schwer_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Zufall_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end SchwierigkeitsgradAuswählen;
   
   
   
   function RasseAuswählen
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Menschen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Kasrodiah_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Lasupin_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Lamustra_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Manuky_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Suroka_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Pryolon_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Talbidahr_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemDatentypen.Moru_Phisihl_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemDatentypen.Larinos_Lotaris_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemDatentypen.Carupex_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return SystemDatentypen.Alary_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 12
      then
         return SystemDatentypen.Tesorahn_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 13
      then
         return SystemDatentypen.Natries_Zermanis_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 14
      then
         return SystemDatentypen.Tridatus_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 15
      then
         return SystemDatentypen.Senelari_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 16
      then
         return SystemDatentypen.Aspari_2_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 17
      then
         return SystemDatentypen.Ekropa_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 18
      then
         return SystemDatentypen.Zufall_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 19
      then
         return SystemDatentypen.Fertig_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end RasseAuswählen;
   
   
   
   function GrafikMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Auflösung_Ändern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Vollbild_Fenster_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Bildrate_Ändern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Speichern_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end GrafikMenü;
   
   
   
   function SoundMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
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
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern - 4
      then
         return SystemDatentypen.Speichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 3
      then
         return SystemDatentypen.Wiederherstellen_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return SystemDatentypen.Zurück_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden_Enum;
                    
      else
         GlobaleVariablen.UmbelegungNummer := AktuelleAuswahlExtern;
         return SystemDatentypen.Eingabe_Enum;
      end if;
      
   end SteuerungMenü;
   
   
            
   function SonstigesMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Anzahl_Speicherstände_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Runden_Bis_Autospeichern_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Sprache_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
   end SonstigesMenü;
   
   
   
   function EditorenMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Kartenfeld_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Einheiten_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Gebäude_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Forschung_Editor_Enum;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Verbesserungen_Editor_Enum;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
      -- return SystemDatentypen.Editoren_Enum;
      
   end EditorenMenü;
   
   
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return SystemDatentypen.Zurück_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemDatentypen.Hauptmenü_Enum;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden_Enum;
                    
      else
         Fehler.LogikFehler (FehlermeldungExtern => "RueckgabeMenues.ZurückHauptmenüEnde - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemDatentypen.Spiel_Beenden_Enum;
      end if;
      
   end ZurückHauptmenüEnde;

end RueckgabeMenues;
