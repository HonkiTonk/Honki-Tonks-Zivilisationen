pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AnzeigeZusatztextRassenmenueSFML;
with AnzeigeZusatztextKartengroesseSFML;
with AnzeigeZusatztextKartenformSFML;

package body AuswahlMenuesZusatztextSFML is

   function MenüsZusatztextAufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Rassen_Menü_Enum =>
            if
              -- Das 1 .. 18 mal für alle Fälle in eine GloaleKonstante mit ErsteRasse .. LetzteRasse umwandeln? äöü
              AktuelleAuswahlExtern in 1 .. 18
            then
               AnzeigeZusatztextRassenmenueSFML.AnzeigeZusatztextRassenmenü (AktuelleAuswahlExtern => AktuelleAuswahlExtern);
         
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
                                                                                    TextpositionExtern    => TextpositionExtern);
            
         when MenueDatentypen.Kartenform_Menü_Enum =>
            AnzeigeZusatztextKartenformSFML.AnzeigeZusatztextKartenform;
            
         when MenueDatentypen.Kartenpole_Menü_Enum =>
            null;
      end case;
      
      return TextpositionExtern;
      
   end MenüsZusatztextAufteilung;

end AuswahlMenuesZusatztextSFML;
