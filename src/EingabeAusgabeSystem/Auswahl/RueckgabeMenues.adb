pragma SPARK_Mode (On);

package body RueckgabeMenues is
   
   function RückgabeMenüs
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive;
      WelchesMenüExtern : in SystemDatentypen.Welches_Menü_Enum)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      case
        WelchesMenüExtern
      is
         when SystemDatentypen.Haupt_Menü =>
            return Hauptmenü (AnfangExtern          => AnfangExtern,
                               EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Spiel_Menü =>
            return Spielmenü (AnfangExtern          => AnfangExtern,
                               EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Optionen_Menü =>
            return Optionsmenü (AnfangExtern          => AnfangExtern,
                                 EndeExtern            => EndeExtern,
                                 AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartengröße_Menü =>
            return KartengrößeAuswählen (AnfangExtern          => AnfangExtern,
                                            EndeExtern            => EndeExtern,
                                            AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartenart_Menü =>
            return KartenartAuswählen (AnfangExtern          => AnfangExtern,
                                        EndeExtern            => EndeExtern,
                                        AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartenform_Menü =>
            return KartenformAuswählen (AnfangExtern          => AnfangExtern,
                                         EndeExtern            => EndeExtern,
                                         AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartentemperatur_Menü =>
            return KartentemperaturAuswählen (AnfangExtern          => AnfangExtern,
                                               EndeExtern            => EndeExtern,
                                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Kartenressourcen_Menü =>
            return KartenRessourcenAuswählen (AnfangExtern          => AnfangExtern,
                                               EndeExtern            => EndeExtern,
                                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Schwierigkeitsgrad_Menü =>
            return SchwierigkeitsgradAuswählen (AnfangExtern          => AnfangExtern,
                                                 EndeExtern            => EndeExtern,
                                                 AktuelleAuswahlExtern => AktuelleAuswahlExtern);
                        
         when SystemDatentypen.Rassen_Menü =>
            return RasseAuswählen (AnfangExtern          => AnfangExtern,
                                    EndeExtern            => EndeExtern,
                                    AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Grafik_Menü =>
            return GrafikMenü (AnfangExtern          => AnfangExtern,
                                EndeExtern            => EndeExtern,
                                AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Sound_Menü =>
            return SoundMenü (AnfangExtern          => AnfangExtern,
                               EndeExtern            => EndeExtern,
                               AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Steuerung_Menü =>
            return SteuerungMenü (AnfangExtern          => AnfangExtern,
                                   EndeExtern            => EndeExtern,
                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Sonstiges_Menü =>
            return SonstigesMenü (AnfangExtern          => AnfangExtern,
                                   EndeExtern            => EndeExtern,
                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end case;
      
   end RückgabeMenüs;
   
   

   function Hauptmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Start_Weiter;
                  
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Laden;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Optionen;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Informationen;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Würdigungen;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
      end if;
      
   end Hauptmenü;
   
   
   
   function Spielmenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Start_Weiter;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Speichern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Laden;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Optionen;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Grafik;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Sound;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Steuerung;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Sonstiges;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Karte_Größe_20_20;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Größe_40_40;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Größe_80_80;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Größe_120_80;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Größe_120_160;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Karte_Größe_160_160;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Karte_Größe_240_240;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Karte_Größe_320_320;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemDatentypen.Karte_Größe_1000_1000;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemDatentypen.Karte_Größe_Nutzer;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemDatentypen.Karte_Größe_Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Karte_Art_Inseln;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Art_Kontinente;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Art_Pangäa;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Art_Nur_Land;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Art_Chaos;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Karte_Form_X_Zylinder;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Form_Y_Zylinder;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Form_Torus;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Form_Kugel;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Form_Viereck;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Karte_Form_Kugel_Gedreht;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Karte_Form_Tugel;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Karte_Form_Tugel_Gedreht;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemDatentypen.Karte_Form_Tugel_Extrem;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Karte_Temperatur_Kalt;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Temperatur_Gemäßigt;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Temperatur_Heiß;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Temperatur_Eiszeit;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Temperatur_Wüste;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Karte_Ressource_Arm;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Karte_Ressource_Wenig;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Karte_Ressource_Mittel;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Karte_Ressource_Viel;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Karte_Ressource_Überfluss;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Schwierigkeitsgrad_Leicht;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Schwierigkeitsgrad_Mittel;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Schwierigkeitsgrad_Schwer;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Menschen;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Kasrodiah;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Lasupin;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Lamustra;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Manuky;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Suroka;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemDatentypen.Pryolon;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemDatentypen.Talbidahr;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemDatentypen.Moru_Phisihl;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemDatentypen.Larinos_Lotaris;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemDatentypen.Carupex;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return SystemDatentypen.Alary;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 12
      then
         return SystemDatentypen.Tesorahn;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 13
      then
         return SystemDatentypen.Natries_Zermanis;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 14
      then
         return SystemDatentypen.Tridatus;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 15
      then
         return SystemDatentypen.Senelari;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 16
      then
         return SystemDatentypen.Aspari_2;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 17
      then
         return SystemDatentypen.Ekropa;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 18
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 19
      then
         return SystemDatentypen.Fertig;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 20
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 21
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Auflösung_Ändern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Farbtiefe_Ändern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Bildrate_Ändern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
      end if;
      
   end GrafikMenü;
   
   
   
   -- Ab hier umbauen
   function SoundMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Eingabe;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Zufall;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
      end if;
      
   end SoundMenü;
   
   
            
   function SteuerungMenü
     (AnfangExtern : in Positive;
      EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = AnfangExtern
      then
         return SystemDatentypen.Eingabe;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
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
         return SystemDatentypen.Eingabe;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
         
      elsif
        AktuelleAuswahlExtern not in AnfangExtern .. EndeExtern
      then
         raise Program_Error;
                    
      else
         raise Constraint_Error;
      end if;
      
   end SonstigesMenü;

end RueckgabeMenues;
