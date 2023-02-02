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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Integer
   is begin
      
      case
        LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                         SpeziesZweiExtern => KontaktierteSpeziesExtern)
      is
         when DiplomatieDatentypen.Krieg_Enum =>
            return 1;
            
         when others =>
            return Handeln (SpeziesExtern             => SpeziesExtern,
                            KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
      end case;
      
   end Handelsmenü;
   
   
   
   function Handeln
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Integer
   is begin
      
      HandelSchleife:
      loop
                  
         case
           AuswahlHandeln
         is
            when 1 =>
               -- Karten tauschen
               SichtbarkeitTauschen (SpeziesEinsExtern => SpeziesExtern,
                                     SpeziesZweiExtern => KontaktierteSpeziesExtern);
               
            when 2 =>
               -- Karten kaufen
               SichtbarkeitKaufen (SpeziesEinsExtern => SpeziesExtern,
                                   SpeziesZweiExtern => KontaktierteSpeziesExtern);
               
            when 3 =>
               -- Karten verkaufen
               SichtbarkeitVerkaufen (SpeziesEinsExtern => SpeziesExtern,
                                      SpeziesZweiExtern => KontaktierteSpeziesExtern);
               
            when 4 =>
               -- Kontakte tauschen
               KontakteTauschen (SpeziesExtern             => SpeziesExtern,
                                 KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
               
            when 5 =>
               -- Kontakte kaufen
               KontakteKaufen (SpeziesExtern             => SpeziesExtern,
                               KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
               
            when 6 =>
               -- Kontakte verkaufen
               KontakteVerkaufen (SpeziesExtern             => SpeziesExtern,
                                  KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
               
            when 7 =>
               -- Geld verschenken
               GeldVerschenken (SpeziesExtern             => SpeziesExtern,
                                KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
               
            when 8 =>
               -- Geld verlangen
               GeldVerlangen (SpeziesExtern             => SpeziesExtern,
                              KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
               
               --   when RueckgabeDatentypen.Zurück_Enum =>
            when 9 =>
               return 1;
               
            when others =>
               null;
         end case;
         
      end loop HandelSchleife;
      
   end Handeln;
   
   
   
   procedure GeldVerschenken
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      if
        LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern) >= Positive'First
      then
         --      Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
         --                                     ZeileExtern         => 11,
         --                                      ZahlenMinimumExtern => 0,
         --                                      ZahlenMaximumExtern => LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern));
               
         SchreibeWichtiges.Geldmenge (SpeziesExtern       => SpeziesExtern,
                                      GeldZugewinnExtern  => -Geldmenge,
                                      RechnenSetzenExtern => True);
               
         SchreibeWichtiges.Geldmenge (SpeziesExtern       => KontaktierteSpeziesExtern,
                                      GeldZugewinnExtern  => Geldmenge,
                                      RechnenSetzenExtern => True);
                  
         -- if
         --    Geldmenge / 25 > Integer (ProduktionDatentypen.Feldproduktion'Last)
         --  then
         SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => KontaktierteSpeziesExtern,
                                               SpeziesZweiExtern   => SpeziesExtern,
                                               SympathieExtern     => DiplomatieDatentypen.Meinung'Last,
                                               RechnenSetzenExtern => False);
                     
         --  else
         SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => KontaktierteSpeziesExtern,
                                               SpeziesZweiExtern   => SpeziesExtern,
                                               SympathieExtern     => DiplomatieDatentypen.Meinung (Geldmenge / 25),
                                               RechnenSetzenExtern => True);
         --   end if;
                  
      else
         null;
      end if;
      
   end GeldVerschenken;
   
   
   
   procedure GeldVerlangen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      if
        LeseWichtiges.Geldmenge (SpeziesExtern => KontaktierteSpeziesExtern) >= Positive'First
      then
         --  Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
         --                                  ZeileExtern         => 12,
         --                                  ZahlenMinimumExtern => 0,
         --                                  ZahlenMaximumExtern => LeseWichtiges.Geldmenge (SpeziesExtern => KontaktierteSpeziesExtern));
               
         SchreibeWichtiges.Geldmenge (SpeziesExtern       => SpeziesExtern,
                                      GeldZugewinnExtern  => Geldmenge,
                                      RechnenSetzenExtern => True);
               
         SchreibeWichtiges.Geldmenge (SpeziesExtern       => KontaktierteSpeziesExtern,
                                      GeldZugewinnExtern  => -Geldmenge,
                                      RechnenSetzenExtern => True);
                  
         --  if
         --    Geldmenge / 25 > Integer (ProduktionDatentypen.Feldproduktion'Last)
         --  then
         --   DiplomatischerZustand.SympathieÄndern (EigeneSpeziesExtern => KontaktierteSpeziesExtern,
         --                                          FremdeSpeziesExtern => SpeziesExtern,
         --                                         ÄnderungExtern    => -DiplomatieDatentypen.Meinung'Last);
                     
         --  else
         --  DiplomatischerZustand.SympathieÄndern (EigeneSpeziesExtern => KontaktierteSpeziesExtern,
         --                                        FremdeSpeziesExtern => SpeziesExtern,
         --                                      ÄnderungExtern    => -DiplomatieDatentypen.Meinung (Geldmenge / 25));
         --  end if;
                  
      else
         null;
      end if;
      
   end GeldVerlangen;
   
   
   
   procedure KontakteVerkaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
               
         if
           (SpeziesSchleifenwert = SpeziesExtern
            or
              SpeziesSchleifenwert = KontaktierteSpeziesExtern)
           or else
             (DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                                     SpeziesZweiExtern => SpeziesSchleifenwert)
              or
                DiplomatieDatentypen.Unbekannt_Enum /= LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => KontaktierteSpeziesExtern,
                                                                                        SpeziesZweiExtern => SpeziesSchleifenwert))
         then
            null;
                  
         else
            KennenlernenLogik.Erstkontakt (EigeneSpeziesExtern => KontaktierteSpeziesExtern,
                                           FremdeSpeziesExtern => SpeziesSchleifenwert);
         end if;
               
      end loop SpeziesSchleife;
      
   end KontakteVerkaufen;
   
   
   
   procedure KontakteKaufen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
               
         if
           SpeziesSchleifenwert = SpeziesExtern
           or
             SpeziesSchleifenwert = KontaktierteSpeziesExtern
         then
            null;
            
         elsif
           DiplomatieDatentypen.Unbekannt_Enum = LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => KontaktierteSpeziesExtern,
                                                                                  SpeziesZweiExtern => SpeziesSchleifenwert)
           or
             DiplomatieDatentypen.Unbekannt_Enum /= LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => SpeziesExtern,
                                                                                     SpeziesZweiExtern => SpeziesSchleifenwert)
         then
            null;
            
         else
            KennenlernenLogik.Erstkontakt (EigeneSpeziesExtern => SpeziesExtern,
                                           FremdeSpeziesExtern => SpeziesSchleifenwert);
         end if;
               
      end loop SpeziesSchleife;
      
   end KontakteKaufen;
   
   
   
   procedure KontakteTauschen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KontaktierteSpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      KontakteKaufen (SpeziesExtern             => SpeziesExtern,
                      KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
      KontakteVerkaufen (SpeziesExtern             => SpeziesExtern,
                         KontaktierteSpeziesExtern => KontaktierteSpeziesExtern);
      
   end KontakteTauschen;
   
   
   
   procedure SichtbarkeitKaufen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
     
      EAchseEinsSchleife:
      for EAchseEinsSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseEinsSchleife:
         for YAchseEinsSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseEinsSchleife:
            for XAchseEinsSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

               if
                 False = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                                 SpeziesExtern     => SpeziesEinsExtern)
                 and
                   True = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                                  SpeziesExtern     => SpeziesZweiExtern)
               then
                  SichtbarkeitSetzenLogik.SichtbarkeitSetzen (SpeziesExtern     => SpeziesEinsExtern,
                                                              KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert));
                        
               else
                  null;
               end if;

            end loop XAchseEinsSchleife;
         end loop YAchseEinsSchleife;
      end loop EAchseEinsSchleife;
     
   end SichtbarkeitKaufen;



   procedure SichtbarkeitVerkaufen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
  
      EAchseZweiSchleife:
      for EAchseZweiSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseZweiSchleife:
         for YAchseZweiSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseZweiSchleife:
            for XAchseZweiSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop

               if
                 False = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                                 SpeziesExtern     => SpeziesZweiExtern)
                 and
                   True = LeseWeltkarte.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                                  SpeziesExtern     => SpeziesEinsExtern)
               then
                  SichtbarkeitSetzenLogik.SichtbarkeitSetzen (SpeziesExtern     => SpeziesZweiExtern,
                                                              KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert));
                        
               else
                  null;
               end if;

            end loop XAchseZweiSchleife;
         end loop YAchseZweiSchleife;
      end loop EAchseZweiSchleife;
  
   end SichtbarkeitVerkaufen;
   
   
   
   procedure SichtbarkeitTauschen
     (SpeziesEinsExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      SpeziesZweiExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      SichtbarkeitKaufen (SpeziesEinsExtern => SpeziesEinsExtern,
                          SpeziesZweiExtern => SpeziesZweiExtern);
      SichtbarkeitVerkaufen (SpeziesEinsExtern => SpeziesEinsExtern,
                             SpeziesZweiExtern => SpeziesZweiExtern);
              
   end SichtbarkeitTauschen;

end HandelnLogik;
