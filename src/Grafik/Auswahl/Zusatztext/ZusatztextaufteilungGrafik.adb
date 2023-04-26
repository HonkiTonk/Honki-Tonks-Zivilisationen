with SpeziesDatentypen;
with AuswahlKonstanten;

with ZusatztextSpeziesmenueGrafik;
with ZusatztextKartengroesseGrafik;
with ZusatztextKartenformGrafik;
with ZusatztextDiplomatieGrafik;

package body ZusatztextaufteilungGrafik is

   function Zusatztextaufteilung
     (WelchesMenüExtern : in MenueDatentypen.Menü_Zusatztext_Einfach_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      RealeViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Kartengröße_Menü_Enum =>
            if
              AktuelleAuswahlExtern > AnzahlKartengrößen
            then
               AktuelleAuswahl := AuswahlKonstanten.LeerAuswahl;
               
            else
               AktuelleAuswahl := AktuelleAuswahlExtern;
            end if;
            
            return ZusatztextKartengroesseGrafik.ZusatztextKartengröße (AktuelleAuswahlExtern => AktuelleAuswahl,
                                                                          ViewflächeExtern      => ViewflächeExtern,
                                                                          RealeViewbreiteExtern => RealeViewbreiteExtern);
            
         when MenueDatentypen.Diplomatie_Menü_Enum =>
            return ZusatztextDiplomatieGrafik.ZusatztextDiplomatie (ViewflächeExtern      => ViewflächeExtern,
                                                                    RealeViewbreiteExtern => RealeViewbreiteExtern);
            
         when MenueDatentypen.Kartenpole_Menü_Enum =>
            null;
      end case;
      
      return ViewflächeExtern;
      
   end Zusatztextaufteilung;
   
   
   
   function ZusatztextDoppelmenü
     (WelchesMenüExtern : in MenueDatentypen.Menü_Doppelt_Enum;
      AktuelleAuswahlExtern : in Natural;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      case
        WelchesMenüExtern
      is
         when MenueDatentypen.Spezies_Menü_Enum =>
            if
              AktuelleAuswahlExtern in SpeziesDatentypen.SpeziesnummernVorhanden'Range
            then
               return ZusatztextSpeziesmenueGrafik.ZusatztextSpeziesmenü (AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                                                           ViewflächeExtern      => ViewflächeExtern);
               
            else
               null;
            end if;
               
         when MenueDatentypen.Kartenform_Menü_Enum =>
            if
              -- Dafür später auch was universelleres bauen? äöü
              AktuelleAuswahlExtern in 1 .. 6
            then
               ZusatztextKartenformGrafik.ZusatztextKartenform (AktuelleAuswahlExtern => AktuelleAuswahlExtern,
                                                                ViewflächeExtern      => ViewflächeExtern);
               
            else
               null;
            end if;
      end case;
      
      return ViewflächeExtern;
      
   end ZusatztextDoppelmenü;

end ZusatztextaufteilungGrafik;
