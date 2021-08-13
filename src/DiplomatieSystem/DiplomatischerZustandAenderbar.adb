pragma SPARK_Mode (On);

with GlobaleTexte, GlobaleKonstanten;

with Anzeige, DiplomatischerZustand;

package body DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern, RasseZweiExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in GlobaleDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is begin
      
      if
        NeuerStatusExtern = GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 22);
         return False;
         
      else
         AktuellerStatus := DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseEinsExtern,
                                                                               FremdeRasseExtern => RasseZweiExtern);
         
         ZeitSeitÄnderung := DiplomatischerZustand.DiplomatischerStatusLetzteÄnderung (EigeneRasseExtern => RasseEinsExtern,
                                                                                         FremdeRasseExtern => RasseZweiExtern);
         
         -- Die Sympathiewerte einer Rasse zu einer Anderen müssen nur Zwei zu Eins berückstichtigt werden, da Eins ja was von Zwei will.
         SympathieZweiZuEins := DiplomatischerZustand.AktuelleSympathie (EigeneRasseExtern => RasseZweiExtern,
                                                                         FremdeRasseExtern => RasseEinsExtern);
      end if;
      
      case
        NeuerStatusExtern
      is
         when GlobaleDatentypen.Neutral =>
            ÄnderungMöglich := NeutralMöglich;
                        
         when GlobaleDatentypen.Nichtangriffspakt =>
            ÄnderungMöglich := NichtangriffspaktMöglich;
                        
         when GlobaleDatentypen.Krieg =>
            ÄnderungMöglich := KriegMöglich;            
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
      
      return ÄnderungMöglich;
      
   end StatusÄnderbarkeitPrüfen;
   
   
   
   procedure EsHerrschtKrieg
   is begin
      
      Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                            TextZeileExtern => 23);
      
   end EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     return Boolean
   is begin
      
      if
        AktuellerStatus = GlobaleDatentypen.Nichtangriffspakt
        and
          ZeitSeitÄnderung >= GlobaleKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      elsif
        AktuellerStatus = GlobaleDatentypen.Krieg
        and
          ZeitSeitÄnderung >= 10
          and
            SympathieZweiZuEins >= DiplomatischerZustand.SympathieGrenzen (AktuellerStatus) - 20
      then
         return True;
         
      else
         return False;
      end if;
      
   end NeutralMöglich;
   
   
   
   function NichtangriffspaktMöglich
     return Boolean
   is begin
      
      if
        AktuellerStatus = GlobaleDatentypen.Krieg
      then
         EsHerrschtKrieg;
         return False;
         
      elsif
        AktuellerStatus = GlobaleDatentypen.Neutral
        and
          SympathieZweiZuEins >= DiplomatischerZustand.SympathieGrenzen (AktuellerStatus) - 10
      then
         return True;
         
      else
         return False;
      end if;
      
   end NichtangriffspaktMöglich;
   
   
   
   function KriegMöglich
     return Boolean
   is begin
      
      if        
        AktuellerStatus = GlobaleDatentypen.Nichtangriffspakt
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 24);
         return False;
         
      elsif
        AktuellerStatus = GlobaleDatentypen.Neutral
        and
          ZeitSeitÄnderung >= GlobaleKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      else
         return False;
      end if;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbar;
