pragma SPARK_Mode (On);

with GlobaleVariablen;
with SystemKonstanten;
with KartenEinstellungenKonstanten;

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
         return SystemKonstanten.StartWeiterKonstante;
                  
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.LadenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.OptionenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemKonstanten.EditorenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemKonstanten.InformationenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemKonstanten.WürdigungenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemKonstanten.SpielBeendenKonstante;
                    
      else
         Fehler.LogikStopp (FehlermeldungExtern => "RueckgabeMenues.Hauptmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemKonstanten.SpielBeendenKonstante;
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
         return SystemKonstanten.StartWeiterKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.SpeichernKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.LadenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemKonstanten.OptionenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemKonstanten.HauptmenüKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemKonstanten.SpielBeendenKonstante;
                    
      else
         Fehler.LogikStopp (FehlermeldungExtern => "RueckgabeMenues.Spielmenü - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemKonstanten.SpielBeendenKonstante;
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
         return SystemKonstanten.GrafikKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.SoundKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.SteuerungKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemKonstanten.SonstigesKonstante;
                    
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
         return KartenEinstellungenKonstanten.Kartengröße2020Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return KartenEinstellungenKonstanten.Kartengröße4040Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return KartenEinstellungenKonstanten.Kartengröße8080Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return KartenEinstellungenKonstanten.Kartengröße12080Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return KartenEinstellungenKonstanten.Kartengröße120160Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return KartenEinstellungenKonstanten.Kartengröße160160Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return KartenEinstellungenKonstanten.Kartengröße240240Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return KartenEinstellungenKonstanten.Kartengröße320320Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return KartenEinstellungenKonstanten.Kartengröße10001000Konstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return KartenEinstellungenKonstanten.KartengrößeNutzerKonstante;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 10
      then
         return SystemKonstanten.ZufallKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 11
      then
         return KartenEinstellungenKonstanten.KartengrößeZufallKonstante;
                    
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
         return KartenEinstellungenKonstanten.KartenartInselnKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return KartenEinstellungenKonstanten.KartenartKontinenteKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return KartenEinstellungenKonstanten.KartenartPangäaKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return KartenEinstellungenKonstanten.KartenartLandKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return KartenEinstellungenKonstanten.KartenartChaosKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemKonstanten.ZufallKonstante;
                    
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
         return KartenEinstellungenKonstanten.KartenformXZylinderKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return KartenEinstellungenKonstanten.KartenformYZylinderKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return KartenEinstellungenKonstanten.KartenformTorusKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return KartenEinstellungenKonstanten.KartenformKugelKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return KartenEinstellungenKonstanten.KartenformViereckKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return KartenEinstellungenKonstanten.KartenformKugelGedrehtKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 6
      then
         return KartenEinstellungenKonstanten.KartenformTugelKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 7
      then
         return KartenEinstellungenKonstanten.KartenformTugelGedrehtKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 8
      then
         return KartenEinstellungenKonstanten.KartenformTugelExtremKonstante;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 9
      then
         return SystemKonstanten.ZufallKonstante;
                    
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
         return KartenEinstellungenKonstanten.TemperaturKaltKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return KartenEinstellungenKonstanten.TemperaturGemäßigtKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return KartenEinstellungenKonstanten.TemperaturHeißKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return KartenEinstellungenKonstanten.TemperaturEiszeitKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return KartenEinstellungenKonstanten.TemperaturWüsteKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemKonstanten.ZufallKonstante;
                    
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
         return KartenEinstellungenKonstanten.RessourcenArmKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return KartenEinstellungenKonstanten.RessourcenWenigKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return KartenEinstellungenKonstanten.RessourcenMittelKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return KartenEinstellungenKonstanten.RessourcenVielKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return KartenEinstellungenKonstanten.RessourcenÜberflussKonstante;
         
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 5
      then
         return SystemKonstanten.ZufallKonstante;
                    
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
         return SystemKonstanten.ZufallKonstante;
                    
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
         return SystemKonstanten.ZufallKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 19
      then
         return SystemKonstanten.FertigKonstante;
                    
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
         return SystemKonstanten.AuflösungÄndernKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.VollbildFensterKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.BildrateÄndernKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemKonstanten.SpeichernKonstante;
                    
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
         return SystemKonstanten.SpeichernKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 3
      then
         return SystemKonstanten.WiederherstellenKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return SystemKonstanten.ZurückKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemKonstanten.HauptmenüKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemKonstanten.SpielBeendenKonstante;
                    
      else
         GlobaleVariablen.UmbelegungNummer := AktuelleAuswahlExtern;
         return SystemKonstanten.EingabeKonstante;
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
         return SystemKonstanten.AnzahlSpeicherständeKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.RundenBisAutospeichernKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.SpracheKonstante;
                    
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
         return SystemKonstanten.KartenfeldEditorKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 1
      then
         return SystemKonstanten.EinheitenEditorKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 2
      then
         return SystemKonstanten.GebäudeEditorKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 3
      then
         return SystemKonstanten.ForschungEditorKonstante;
                    
      elsif
        AktuelleAuswahlExtern = AnfangExtern + 4
      then
         return SystemKonstanten.VerbesserungenEditorKonstante;
                    
      else
         return ZurückHauptmenüEnde (EndeExtern            => EndeExtern,
                                       AktuelleAuswahlExtern => AktuelleAuswahlExtern);
      end if;
      
      -- return SystemKonstanten.EditorenKonstante;
      
   end EditorenMenü;
   
   
   
   function ZurückHauptmenüEnde
     (EndeExtern : in Positive;
      AktuelleAuswahlExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum
   is begin
      
      if
        AktuelleAuswahlExtern = EndeExtern - 2
      then
         return SystemKonstanten.ZurückKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern - 1
      then
         return SystemKonstanten.HauptmenüKonstante;
                    
      elsif
        AktuelleAuswahlExtern = EndeExtern
      then
         return SystemKonstanten.SpielBeendenKonstante;
                    
      else
         Fehler.LogikStopp (FehlermeldungExtern => "RueckgabeMenues.ZurückHauptmenüEnde - Ungültige Auswahl.");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return SystemKonstanten.SpielBeendenKonstante;
      end if;
      
   end ZurückHauptmenüEnde;

end RueckgabeMenues;
