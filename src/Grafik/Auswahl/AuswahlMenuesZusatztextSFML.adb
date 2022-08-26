pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;

with AnzeigeZusatztextRassenmenueSFML;
with AnzeigeZusatztextKartengroesseSFML;
with AnzeigeZusatztextKartenformSFML;
with ZusatztextDiplomatieSFML;

package body AuswahlMenuesZusatztextSFML is

   -- Das vielleicht auch in zwei Varianten aufteilen? äöü
   function MenüsZusatztextAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float;
      AnzeigebereichbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Rassen_Menü_Enum =>
            if
              AktuelleAuswahlExtern in RassenDatentypen.RassennummernVorhanden'Range
            then
               return AnzeigeZusatztextRassenmenueSFML.AnzeigeZusatztextRassenmenü (AktuelleAuswahlExtern      => AktuelleAuswahlExtern,
                                                                                     AnzeigebereichbreiteExtern => AnzeigebereichbreiteExtern);
               
            else
               null;
            end if;
            
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            if
              AktuelleAuswahlExtern > AnzahlKartengrößen
            then
               AktuelleAuswahl := 0;
               
            else
               AktuelleAuswahl := AktuelleAuswahlExtern;
            end if;
            
            return AnzeigeZusatztextKartengroesseSFML.AnzeigeZusatztextKartengröße (AktuelleAuswahlExtern => AktuelleAuswahl,
                                                                                      ViewflächeExtern      => ViewflächeExtern,
                                                                                      RealeViewbreiteExtern => RealeViewbreiteExtern);
            
         when MenueDatentypen.Diplomatie_Menü_Enum =>
            return ZusatztextDiplomatieSFML.ZusatztextDiplomatie (ViewflächeExtern      => ViewflächeExtern,
                                                                  RealeViewbreiteExtern => RealeViewbreiteExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            if
              -- Dafür später auch was universelleres bauen. äöü
              AktuelleAuswahlExtern in 1 .. 6
            then
               AnzeigeZusatztextKartenformSFML.AnzeigeZusatztextKartenform;
               
            else
               null;
            end if;
            
         when MenueDatentypen.Kartenpole_Menü_Enum =>
            null;
      end case;
      
      return ViewflächeExtern;
      
   end MenüsZusatztextAufteilung;

end AuswahlMenuesZusatztextSFML;
