pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;

with SchreibeWichtiges;
with LeseWichtiges;
with LeseKarten;

with Sichtbarkeit;
with KennenLernen;
with DiplomatischerZustand;
with Karten;

package body Handeln is

   function Handelsmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      case
        SpielVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern).AktuellerZustand
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
         
         --  AuswahlHandeln := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Handeln,
         --                                     TextDateiExtern   => GlobaleTexte.Handeln,
         --                                     FrageZeileExtern  => 1,
         --                                     ErsteZeileExtern  => 2,
         --                                    LetzteZeileExtern => 10);
      
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
         DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                 FremdeRasseExtern => RasseExtern,
                                                 ÄnderungExtern    => DiplomatieDatentypen.Meinung'Last);
                     
         --  else
         DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                 FremdeRasseExtern => RasseExtern,
                                                 ÄnderungExtern    => DiplomatieDatentypen.Meinung (Geldmenge / 25));
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
   is begin
      
      RassenZweiSchleife:
      for RasseZweiSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           RasseZweiSchleifenwert = RasseExtern
           or
             RasseZweiSchleifenwert = KontaktierteRasseExtern
             or
               SpielVariablen.Diplomatie (RasseExtern, RasseZweiSchleifenwert).AktuellerZustand = DiplomatieDatentypen.Unbekannt_Enum
           or
             SpielVariablen.Diplomatie (KontaktierteRasseExtern, RasseZweiSchleifenwert).AktuellerZustand /= DiplomatieDatentypen.Unbekannt_Enum
         then
            null;
                  
         else
            KennenLernen.Erstkontakt (EigeneRasseExtern => KontaktierteRasseExtern,
                                      FremdeRasseExtern => RasseZweiSchleifenwert);
         end if;
               
      end loop RassenZweiSchleife;
      
   end KontakteVerkaufen;
   
   
   
   procedure KontakteKaufen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           RasseEinsSchleifenwert = RasseExtern
           or
             RasseEinsSchleifenwert = KontaktierteRasseExtern
             or
               SpielVariablen.Diplomatie (KontaktierteRasseExtern, RasseEinsSchleifenwert).AktuellerZustand = DiplomatieDatentypen.Unbekannt_Enum
           or
             SpielVariablen.Diplomatie (RasseExtern, RasseEinsSchleifenwert).AktuellerZustand /= DiplomatieDatentypen.Unbekannt_Enum
         then
            null;
                  
         else
            KennenLernen.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                      FremdeRasseExtern => RasseEinsSchleifenwert);
         end if;
               
      end loop RassenEinsSchleife;
      
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
      for EAchseEinsSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseEinsSchleife:
         for YAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseEinsSchleife:
            for XAchseEinsSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop

               if
                 False = LeseKarten.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                              RasseExtern       => RasseEinsExtern)
                 and
                   True = LeseKarten.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                               RasseExtern       => RasseZweiExtern)
               then
                  Sichtbarkeit.SichtbarkeitSetzen (RasseExtern       => RasseEinsExtern,
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
      for EAchseZweiSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseZweiSchleife:
         for YAchseZweiSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
            XAchseZweiSchleife:
            for XAchseZweiSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop

               if
                 False = LeseKarten.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                              RasseExtern       => RasseZweiExtern)
                 and
                   True = LeseKarten.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                               RasseExtern       => RasseEinsExtern)
               then
                  Sichtbarkeit.SichtbarkeitSetzen (RasseExtern       => RasseZweiExtern,
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

end Handeln;
