pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with SystemDatentypen; use SystemDatentypen;
-- with GlobaleTexte;
with WichtigesKonstanten;

-- with TextAnzeigeKonsole;
with DiplomatischerZustand;

package body DiplomatischerZustandAenderbar is

   function StatusÄnderbarkeitPrüfen
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NeuerStatusExtern : in SystemDatentypen.Status_Untereinander_Bekannt_Enum)
      return Boolean
   is begin
      
      if
        NeuerStatusExtern = GlobaleVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand
      then
         -- TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
         --                                                  TextZeileExtern => 22);
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
         when SystemDatentypen.Neutral_Enum =>
            ÄnderungMöglich := NeutralMöglich;
                        
         when SystemDatentypen.Nichtangriffspakt_Enum =>
            ÄnderungMöglich := NichtangriffspaktMöglich;
                        
         when SystemDatentypen.Krieg_Enum =>
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
      
      -- TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
      --                                                  TextZeileExtern => 23);
      
      null;
      
   end EsHerrschtKrieg;
   
   
   
   function NeutralMöglich
     return Boolean
   is begin
      
      if
        AktuellerStatus = SystemDatentypen.Nichtangriffspakt_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      elsif
        AktuellerStatus = SystemDatentypen.Krieg_Enum
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
        AktuellerStatus = SystemDatentypen.Krieg_Enum
      then
         EsHerrschtKrieg;
         return False;
         
      elsif
        AktuellerStatus = SystemDatentypen.Neutral_Enum
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
        AktuellerStatus = SystemDatentypen.Nichtangriffspakt_Enum
      then
         -- TextAnzeigeKonsole.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
         --                                                  TextZeileExtern => 24);
         return False;
         
      elsif
        AktuellerStatus = SystemDatentypen.Neutral_Enum
        and
          ZeitSeitÄnderung >= WichtigesKonstanten.DiplomatischerStatusÄnderungszeit
      then
         return True;
         
      else
         return False;
      end if;
      
   end KriegMöglich;

end DiplomatischerZustandAenderbar;
