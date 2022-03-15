pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with SystemKonstanten;

with SchreibeWichtiges;
with LeseWichtiges;
with LeseKarten;

with Auswahl;
with Sichtbarkeit;
with KennenLernen;
with Eingabe;
with DiplomatischerZustand;
with Karten;

package body Handeln is

   function Handelsmenü
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      case
        GlobaleVariablen.Diplomatie (RasseExtern, KontaktierteRasseExtern).AktuellerZustand
      is
         when SystemDatentypen.Krieg =>
            return 1;
            
         when others =>
            return Handeln (RasseExtern             => RasseExtern,
                            KontaktierteRasseExtern => KontaktierteRasseExtern);
      end case;
      
   end Handelsmenü;
   
   
   
   function Handeln
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Integer
   is begin
      
      HandelSchleife:
      loop
         
         AuswahlHandeln := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Handeln,
                                            TextDateiExtern   => GlobaleTexte.Handeln,
                                            FrageZeileExtern  => 1,
                                            ErsteZeileExtern  => 2,
                                            LetzteZeileExtern => 10);
      
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
               
            when SystemKonstanten.ZurückKonstante =>
               return 1;
               
            when others =>
               null;
         end case;
         
      end loop HandelSchleife;
      
   end Handeln;
   
   
   
   procedure GeldVerschenken
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseWichtiges.Geldmenge (RasseExtern => RasseExtern) >= Positive'First
      then
         Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
                                         ZeileExtern         => 11,
                                         ZahlenMinimumExtern => 0,
                                         ZahlenMaximumExtern => LeseWichtiges.Geldmenge (RasseExtern => RasseExtern));
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                      GeldZugewinnExtern  => -Geldmenge,
                                      RechnenSetzenExtern => True);
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => KontaktierteRasseExtern,
                                      GeldZugewinnExtern  => Geldmenge,
                                      RechnenSetzenExtern => True);
                  
         if
           Geldmenge / 25 > Integer (EinheitStadtDatentypen.ProduktionFeld'Last)
         then
            DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                    FremdeRasseExtern => RasseExtern,
                                                    ÄnderungExtern    => EinheitStadtDatentypen.ProduktionFeld'Last);
                     
         else
            DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                    FremdeRasseExtern => RasseExtern,
                                                    ÄnderungExtern    => EinheitStadtDatentypen.ProduktionFeld (Geldmenge / 25));
         end if;
                  
      else
         null;
      end if;
      
   end GeldVerschenken;
   
   
   
   procedure GeldVerlangen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        LeseWichtiges.Geldmenge (RasseExtern => KontaktierteRasseExtern) >= Positive'First
      then
         Geldmenge := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Handeln,
                                         ZeileExtern         => 12,
                                         ZahlenMinimumExtern => 0,
                                         ZahlenMaximumExtern => LeseWichtiges.Geldmenge (RasseExtern => KontaktierteRasseExtern));
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => RasseExtern,
                                      GeldZugewinnExtern  => Geldmenge,
                                      RechnenSetzenExtern => True);
               
         SchreibeWichtiges.Geldmenge (RasseExtern         => KontaktierteRasseExtern,
                                      GeldZugewinnExtern  => -Geldmenge,
                                      RechnenSetzenExtern => True);
                  
         if
           Geldmenge / 25 > Integer (EinheitStadtDatentypen.ProduktionFeld'Last)
         then
            DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                    FremdeRasseExtern => RasseExtern,
                                                    ÄnderungExtern    => -EinheitStadtDatentypen.ProduktionFeld'Last);
                     
         else
            DiplomatischerZustand.SympathieÄndern (EigeneRasseExtern => KontaktierteRasseExtern,
                                                    FremdeRasseExtern => RasseExtern,
                                                    ÄnderungExtern    => -EinheitStadtDatentypen.ProduktionFeld (Geldmenge / 25));
         end if;
                  
      else
         null;
      end if;
      
   end GeldVerlangen;
   
   
   
   procedure KontakteVerkaufen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      RassenZweiSchleife:
      for RasseZweiSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           RasseZweiSchleifenwert = RasseExtern
           or
             RasseZweiSchleifenwert = KontaktierteRasseExtern
             or
               GlobaleVariablen.Diplomatie (RasseExtern, RasseZweiSchleifenwert).AktuellerZustand = SystemDatentypen.Unbekannt
           or
             GlobaleVariablen.Diplomatie (KontaktierteRasseExtern, RasseZweiSchleifenwert).AktuellerZustand /= SystemDatentypen.Unbekannt
         then
            null;
                  
         else
            KennenLernen.Erstkontakt (EigeneRasseExtern => KontaktierteRasseExtern,
                                      FremdeRasseExtern => RasseZweiSchleifenwert);
         end if;
               
      end loop RassenZweiSchleife;
      
   end KontakteVerkaufen;
   
   
   
   procedure KontakteKaufen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      RassenEinsSchleife:
      for RasseEinsSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
               
         if
           RasseEinsSchleifenwert = RasseExtern
           or
             RasseEinsSchleifenwert = KontaktierteRasseExtern
             or
               GlobaleVariablen.Diplomatie (KontaktierteRasseExtern, RasseEinsSchleifenwert).AktuellerZustand = SystemDatentypen.Unbekannt
           or
             GlobaleVariablen.Diplomatie (RasseExtern, RasseEinsSchleifenwert).AktuellerZustand /= SystemDatentypen.Unbekannt
         then
            null;
                  
         else
            KennenLernen.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                      FremdeRasseExtern => RasseEinsSchleifenwert);
         end if;
               
      end loop RassenEinsSchleife;
      
   end KontakteKaufen;
   
   
   
   procedure KontakteTauschen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      KontakteKaufen (RasseExtern             => RasseExtern,
                      KontaktierteRasseExtern => KontaktierteRasseExtern);
      KontakteVerkaufen (RasseExtern             => RasseExtern,
                         KontaktierteRasseExtern => KontaktierteRasseExtern);
      
   end KontakteTauschen;
   
   
   
   procedure SichtbarkeitKaufen
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
     
      EAchseEinsSchleife:
      for EAchseEinsSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseEinsSchleife:
         for YAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseEinsSchleife:
            for XAchseEinsSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop

               if
                 LeseKarten.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                      RasseExtern       => RasseEinsExtern)
                 = False
                 and
                   LeseKarten.Sichtbar (KoordinatenExtern => (EAchseEinsSchleifenwert, YAchseEinsSchleifenwert, XAchseEinsSchleifenwert),
                                        RasseExtern       => RasseZweiExtern)
                 = True
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
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
  
      EAchseZweiSchleife:
      for EAchseZweiSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseZweiSchleife:
         for YAchseZweiSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseZweiSchleife:
            for XAchseZweiSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop

               if
                 LeseKarten.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                      RasseExtern       => RasseZweiExtern)
                 = False
                 and
                   LeseKarten.Sichtbar (KoordinatenExtern => (EAchseZweiSchleifenwert, YAchseZweiSchleifenwert, XAchseZweiSchleifenwert),
                                        RasseExtern       => RasseEinsExtern)
                 = True
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
     (RasseEinsExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SichtbarkeitKaufen (RasseEinsExtern => RasseEinsExtern,
                          RasseZweiExtern => RasseZweiExtern);
      SichtbarkeitVerkaufen (RasseEinsExtern => RasseEinsExtern,
                             RasseZweiExtern => RasseZweiExtern);
              
   end SichtbarkeitTauschen;

end Handeln;
