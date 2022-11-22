with DiplomatieDatentypen;
with KartenKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;
with LeseWeltkarte;
with LeseWeltkarteneinstellungen;
with LeseDiplomatie;
with SchreibeDiplomatie;

with SichtbarkeitSetzenLogik;
with KennenlernenLogik;

package body HandelnLogik is

   function Handelsmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                         RasseZweiExtern => KontaktierteRasseExtern)
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            return 1;
            
         when others =>
            return Handeln (RasseExtern             => RasseExtern,
                            KontaktierteRasseExtern => KontaktierteRasseExtern);
      end case;
      
   end Handelsmenü;
   
   
   
   function Handeln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      HandelSchleife:
      loop
                  
         case
           AuswahlHandeln
         is
            when 1 =>
               -- Karten tauschen
               SichtbarkeitTauschen (RasseEinsExtern => RasseExtern,
                                     RasseZweiExtern => KontaktierteRasseExtern);
               
            when 2 =>
               -- Karten kaufen
               SichtbarkeitKaufen (RasseEinsExtern => RasseExtern,
                                   RasseZweiExtern => KontaktierteRasseExtern);
               
            when 3 =>
               -- Karten verkaufen
               SichtbarkeitVerkaufen (RasseEinsExtern => RasseExtern,
                                      RasseZweiExtern => KontaktierteRasseExtern);
               
            when 4 =>
               -- Kontakte tauschen
               KontakteTauschen (RasseExtern             => RasseExtern,
                                 KontaktierteRasseExtern => KontaktierteRasseExtern);
               
            when 5 =>
               -- Kontakte kaufen
               KontakteKaufen (RasseExtern             => RasseExtern,
                               KontaktierteRasseExtern => KontaktierteRasseExtern);
               
            when 6 =>
               -- Kontakte verkaufen
               KontakteVerkaufen (RasseExtern             => RasseExtern,
                                  KontaktierteRasseExtern => KontaktierteRasseExtern);
               
            when 7 =>
               -- Geld verschenken
               GeldVerschenken (RasseExtern             => RasseExtern,
                                KontaktierteRasseExtern => KontaktierteRasseExtern);
               
            when 8 =>
               -- Geld verlangen
               GeldVerlangen (RasseExtern             => RasseExtern,
                              KontaktierteRasseExtern => KontaktierteRasseExtern);
               
               --   when RueckgabeDatentypen.Zurück_Enum =>
            when 9 =>
               return 1;
               
            when others =>
               null;
         end case;
         
      end loop HandelSchleife;
      
   end Handeln;
   
   
   
   procedure GeldVerschenken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseWichtiges.Geldmenge (RasseExtern => RasseExtern) >= Positive'First
      then
         --      Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
         --                                     ZeileExtern         => 11,
         --                                      ZahlenMinimumExtern => 0,
         --                                      ZahlenMaximumExtern => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern));
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                      GeldZugewinnExtern  => -Geldmenge,
                                      RechnenSetzenExtern => True);
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => KontaktierteRasseExtern,
                                      GeldZugewinnExtern  => Geldmenge,
                                      RechnenSetzenExtern => True);
                  
         -- if
         --    Geldmenge / 25 > Integer (ProduktionDatentypen.Feldproduktion'Last)
         --  then
         SchreibeDiplomatie.AktuelleSympathie (RasseEinsExtern     => KontaktierteRasseExtern,
                                               RasseZweiExtern     => RasseExtern,
                                               SympathieExtern     => DiplomatieDatentypen.Meinung'Last,
                                               RechnenSetzenExtern => False);
                     
         --  else
         SchreibeDiplomatie.AktuelleSympathie (RasseEinsExtern     => KontaktierteRasseExtern,
                                               RasseZweiExtern     => RasseExtern,
                                               SympathieExtern     => DiplomatieDatentypen.Meinung (Geldmenge / 25),
                                               RechnenSetzenExtern => True);
         --   end if;
                  
      else
         null;
      end if;
      
   end GeldVerschenken;
   
   
   
   procedure GeldVerlangen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseWichtiges.Geldmenge (RasseExtern => KontaktierteRasseExtern) >= Positive'First
      then
         --  Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
         --                                  ZeileExtern         => 12,
         --                                  ZahlenMinimumExtern => 0,
         --                                  ZahlenMaximumExtern => LeseWichtiges.Geldmenge (RasseExtern => KontaktierteRasseExtern));
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                      GeldZugewinnExtern  => Geldmenge,
                                      RechnenSetzenExtern => True);
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => KontaktierteRasseExtern,
                                      GeldZugewinnExtern  => -Geldmenge,
                                      RechnenSetzenExtern => True);
                  
         --  if
         --    Geldmenge / 25 > Integer (ProduktionDatentypen.Feldproduktion'Last)
         --  then
         --   DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
         --                                          FremdeRasseExtern => RasseExtern,
         --                                         ÄnderungExtern    => -DiplomatieDatentypen.Meinung'Last);
                     
         --  else
         --  DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
         --                                        FremdeRasseExtern => RasseExtern,
         --                                      ÄnderungExtern    => -DiplomatieDatentypen.Meinung (Geldmenge / 25));
         --  end if;
                  
      else
         null;
      end if;
      
   end GeldVerlangen;
   
   
   
   procedure KontakteVerkaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type RassenDatentypen.Rassen_Enum;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           (RasseSchleifenwert = RasseExtern
            or
              RasseSchleifenwert = KontaktierteRasseExtern)
           or else
             (DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                                                                     RasseZweiExtern => RasseSchleifenwert)
              or
                DiplomatieDatentypen.Unbekannt_Enum /= LeseDiplomatie.AktuellerZustand (RasseEinsExtern => KontaktierteRasseExtern,
                                                                                        RasseZweiExtern => RasseSchleifenwert))
         then
            null;
                  
         else
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => KontaktierteRasseExtern,
                                           FremdeRasseExtern => RasseSchleifenwert);
         end if;
               
      end loop RassenSchleife;
      
   end KontakteVerkaufen;
   
   
   
   procedure KontakteKaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type RassenDatentypen.Rassen_Enum;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           RasseSchleifenwert = RasseExtern
            or
             RasseSchleifenwert = KontaktierteRasseExtern
         then
            null;
            
         elsif
           DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (RasseEinsExtern => KontaktierteRasseExtern,
                                                                                  RasseZweiExtern => RasseSchleifenwert)
           or
             DiplomatieDatentypen.Unbekannt_Enum /= LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                                                                     RasseZweiExtern => RasseSchleifenwert)
         then
            null;
            
         else
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                           FremdeRasseExtern => RasseSchleifenwert);
         end if;
               
      end loop RassenSchleife;
      
   end KontakteKaufen;
   
   
   
   procedure KontakteTauschen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KontakteKaufen (RasseExtern             => RasseExtern,
                      KontaktierteRasseExtern => KontaktierteRasseExtern);
      KontakteVerkaufen (RasseExtern             => RasseExtern,
                         KontaktierteRasseExtern => KontaktierteRasseExtern);
      
   end KontakteTauschen;
   
   
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
     
      EAchseEinsSchleife:
      for EAchseEinsSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseEinsSchleife:
         for YAchseEinsSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseEinsSchleife:
            for XAchseEinsSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

               if
                 False = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                                 RasseExtern       => RasseEinsExtern)
                 and
                   True = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                                  RasseExtern       => RasseZweiExtern)
               then
                  SichtbarkeitSetzenLogik.SichtbarkeitSetzen (RasseExtern       => RasseEinsExtern,
                                                              KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert));
                        
               else
                  null;
               end if;

            end loop XAchseEinsSchleife;
         end loop YAchseEinsSchleife;
      end loop EAchseEinsSchleife;
     
   end SichtbarkeitKaufen;



   procedure SichtbarkeitVerkaufen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
  
      EAchseZweiSchleife:
      for EAchseZweiSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseZweiSchleife:
         for YAchseZweiSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseZweiSchleife:
            for XAchseZweiSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

               if
                 False = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                                 RasseExtern       => RasseZweiExtern)
                 and
                   True = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                                  RasseExtern       => RasseEinsExtern)
               then
                  SichtbarkeitSetzenLogik.SichtbarkeitSetzen (RasseExtern       => RasseZweiExtern,
                                                              KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert));
                        
               else
                  null;
               end if;

            end loop XAchseZweiSchleife;
         end loop YAchseZweiSchleife;
      end loop EAchseZweiSchleife;
  
   end SichtbarkeitVerkaufen;
   
   
   
   procedure SichtbarkeitTauschen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SichtbarkeitKaufen (RasseEinsExtern => RasseEinsExtern,
                          RasseZweiExtern => RasseZweiExtern);
      SichtbarkeitVerkaufen (RasseEinsExtern => RasseEinsExtern,
                             RasseZweiExtern => RasseZweiExtern);
              
   end SichtbarkeitTauschen;

end HandelnLogik;
