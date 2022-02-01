pragma SPARK_Mode (On);

with GlobaleVariablen;
with SystemKonstanten;
with KartenKonstanten;

with Fehler;

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
            return SteuerungMenü (EndeExtern            => EndeExtern,
                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
            
         when SystemDatentypen.Sonstiges_Menü =>
            return SonstigesMenü (AnfangExtern          => AnfangExtern,
                                   EndeExtern            => EndeExtern,
                                   AktuelleAuswahlExtern => AktuelleAuswahlExtern);
               
         when SystemDatentypen.Editoren_Menü =>
            return EditorenMenü (AnfangExtern          => AnfangExtern,
                                  EndeExtern            => EndeExtern,
                                  AktuelleAuswahlExtern => AktuelleAuswahlExtern);
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
         return SystemDatentypen.Editoren;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Informationen;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Würdigungen;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         Fehler.LogikStopp (FehlermeldungExtern => "RueckgabeMenues.Hauptmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemDatentypen.Spiel_Beenden;
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
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         Fehler.LogikStopp (FehlermeldungExtern => "RueckgabeMenues.Spielmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemDatentypen.Spiel_Beenden;
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
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return SystemDatentypen.Karte_Größe_Zufall;
                    
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
         return SystemDatentypen.Zufall;
                    
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
         return KartenKonstanten.RessourcenArmKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return KartenKonstanten.RessourcenWenigKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return KartenKonstanten.RessourcenMittelKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return KartenKonstanten.RessourcenVielKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return KartenKonstanten.RessourcenÜberflussKonstante;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemDatentypen.Zufall;
                    
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
         return SystemKonstanten.SchwierigkeitLeichtKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.SchwierigkeitMittelKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.SchwierigkeitSchwerKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Zufall;
                    
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
         return SystemKonstanten.MenschenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.KasrodiahKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.LasupinKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemKonstanten.LamustraKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemKonstanten.ManukyKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemKonstanten.SurokaKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return SystemKonstanten.PryolonKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return SystemKonstanten.TalbidahrKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return SystemKonstanten.MoruPhisihlKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemKonstanten.LarinosLotarisKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemKonstanten.CarupexKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return SystemKonstanten.AlaryKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 12
      then
         return SystemKonstanten.TesorahnKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 13
      then
         return SystemKonstanten.NatriesZermanisKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 14
      then
         return SystemKonstanten.TridatusKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 15
      then
         return SystemKonstanten.SenelariKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 16
      then
         return SystemKonstanten.Aspari2Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 17
      then
         return SystemKonstanten.EkropaKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 18
      then
         return SystemDatentypen.Zufall;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 19
      then
         return SystemDatentypen.Fertig;
                    
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
         return SystemDatentypen.Auflösung_Ändern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Vollbild_Fenster;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Bildrate_Ändern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Speichern;
                    
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
         return SystemDatentypen.Speichern;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 3
      then
         return SystemDatentypen.Wiederherstellen;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         GlobaleVariablen.UmbelegungNummer := AktuelleAuswahlExtern;
         return SystemDatentypen.Eingabe;
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
         return SystemDatentypen.Anzahl_Speicherstände;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Runden_Bis_Autospeichern;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Sprache;
                    
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
         return SystemDatentypen.Kartenfeld_Editor;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemDatentypen.Einheiten_Editor;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemDatentypen.Gebäude_Editor;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemDatentypen.Forschung_Editor;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemDatentypen.Verbesserungen_Editor;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
      -- return SystemDatentypen.Editoren;
      
   end EditorenMenü;
   
   
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return SystemDatentypen.Zurück;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemDatentypen.Hauptmenü;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemDatentypen.Spiel_Beenden;
                    
      else
         Fehler.LogikStopp (FehlermeldungExtern => "RueckgabeMenues.ZurückHauptmenüEnde - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemDatentypen.Spiel_Beenden;
      end if;
      
   end ZurückHauptmenüEnde;

end RueckgabeMenues;
