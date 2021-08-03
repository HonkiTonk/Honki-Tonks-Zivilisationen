pragma SPARK_Mode (On);

with GlobaleTexte;

with Anzeige, DiplomatischerZustand;

package body DiplomatischerZustandAenderbar is

   procedure StatusÄnderbarkeitPrüfen
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in GlobaleDatentypen.Status_Untereinander_Bekannt_Enum)
   is begin
      
      if
        NeuerStatusExtern = GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 22);
         return;
         
      else
         null;
      end if;
      
      case
        NeuerStatusExtern
      is
         when GlobaleDatentypen.Neutral =>
            ÄnderungMöglich := NeutralMöglich (RasseEinsExtern => RasseEinsExtern,
                                                  RasseZweiExtern => RasseZweiExtern);
            
         when GlobaleDatentypen.Offene_Grenzen =>
            ÄnderungMöglich := OffeneGrenzenMöglich (RasseEinsExtern => RasseEinsExtern,
                                                        RasseZweiExtern => RasseZweiExtern);
                        
         when GlobaleDatentypen.Nichtangriffspakt =>
            ÄnderungMöglich := NichtangriffspaktMöglich (RasseEinsExtern => RasseEinsExtern,
                                                            RasseZweiExtern => RasseZweiExtern);
                        
         when GlobaleDatentypen.Defensivbündnis =>
            ÄnderungMöglich := DefensivbündnisMöglich (RasseEinsExtern => RasseEinsExtern,
                                                           RasseZweiExtern => RasseZweiExtern);
            
            
         when GlobaleDatentypen.Offensivbündnis =>
            ÄnderungMöglich := OffensivbündnisMöglich (RasseEinsExtern => RasseEinsExtern,
                                                           RasseZweiExtern => RasseZweiExtern);
                        
         when GlobaleDatentypen.Krieg =>
            ÄnderungMöglich := KriegMöglich (RasseEinsExtern => RasseEinsExtern,
                                                RasseZweiExtern => RasseZweiExtern);            
      end case;
      
      case
        ÄnderungMöglich
      is
         when True =>
            DiplomatischerZustand.DiplomatischenStatusÄndern (RasseEinsExtern   => RasseEinsExtern,
                                                               RasseZweiExtern   => RasseZweiExtern,
                                                               NeuerStatusExtern => NeuerStatusExtern);
            
         when False =>
            null;
      end case;
      
   end StatusÄnderbarkeitPrüfen;
   
   
   
   procedure EsHerrschtKrieg
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                            TextZeileExtern => 23);
      
   end EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        RasseEinsExtern = RasseZweiExtern
      then
         null;
         
      else
         null;
      end if;
      
      return True;
      
   end NeutralMöglich;
   
   
   
   function OffeneGrenzenMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Krieg
      then
         EsHerrschtKrieg;
         return False;
               
      else
         null;
      end if;
      
      return True;
      
   end OffeneGrenzenMöglich;
   
   
   
   function NichtangriffspaktMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Krieg
      then
         EsHerrschtKrieg;
         return False;
               
      else
         null;
      end if;
      
      return True;
      
   end NichtangriffspaktMöglich;
   
   
   
   function DefensivbündnisMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Krieg
      then
         EsHerrschtKrieg;
         return False;
              
      elsif
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Nichtangriffspakt
      then
         null;
               
      else
         null;
      end if;
      
      return True;
      
   end DefensivbündnisMöglich;
   
   
   
   function OffensivbündnisMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Krieg
      then
         EsHerrschtKrieg;
         return False;
               
      elsif
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Nichtangriffspakt
      then
         null;
               
      else
         null;
      end if;
      
      return True;
      
   end OffensivbündnisMöglich;
   
   
   
   function KriegMöglich
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      if
        GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Offensivbündnis
        or
          GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Defensivbündnis
        or
          GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand = GlobaleDatentypen.Nichtangriffspakt
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 24);
         return False;
               
      else
         null;
      end if;
      
      return True;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbar;
