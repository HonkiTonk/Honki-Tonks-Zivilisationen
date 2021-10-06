pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with SonstigesKonstanten;

with Anzeige;
with DiplomatischerZustand;

package body DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SonstigeDatentypen.Status_Untereinander_Bekannt_Enum)
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
         when SonstigeDatentypen.Neutral =>
            ÄnderungMöglich := NeutralMöglich;
                        
         when SonstigeDatentypen.Nichtangriffspakt =>
            ÄnderungMöglich := NichtangriffspaktMöglich;
                        
         when SonstigeDatentypen.Krieg =>
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
        AktuellerStatus = SonstigeDatentypen.Nichtangriffspakt
        and
          ZeitSeitÄnderung >= SonstigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      elsif
        AktuellerStatus = SonstigeDatentypen.Krieg
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
        AktuellerStatus = SonstigeDatentypen.Krieg
      then
         EsHerrschtKrieg;
         return False;
         
      elsif
        AktuellerStatus = SonstigeDatentypen.Neutral
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
        AktuellerStatus = SonstigeDatentypen.Nichtangriffspakt
      then
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                               TextZeileExtern => 24);
         return False;
         
      elsif
        AktuellerStatus = SonstigeDatentypen.Neutral
        and
          ZeitSeitÄnderung >= SonstigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      else
         return False;
      end if;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbar;
