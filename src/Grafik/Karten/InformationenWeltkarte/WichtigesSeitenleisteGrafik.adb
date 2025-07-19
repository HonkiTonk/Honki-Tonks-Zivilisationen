with TextKonstantenHTSEB;

with Spieltexte;
with TextnummernKonstanten;
with ForschungKonstanten;
with ProduktionKonstanten;
with KartenKonstanten;

with LeseWichtiges;
with LeseGrenzen;
with LeseAllgemeines;

with ForschungsbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemErweitertGrafik;

package body WichtigesSeitenleisteGrafik is

   function WichtigesInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      Leerzeilen := 0;
      YTextposition := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      AnzuzeigenderText (1) := Koordinaten (KoordinatenExtern => KoordinatenExtern);
      AnzuzeigenderText (2) := Rundenanzahl (SpeziesExtern => SpeziesExtern);
      AnzuzeigenderText (3) := Geld (SpeziesExtern => SpeziesExtern);
      AnzuzeigenderText (4) := Forschung (SpeziesExtern => SpeziesExtern);
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         if
           AnzuzeigenderText (TextSchleifenwert) = TextKonstantenHTSEB.LeerUnboundedString
         then
            Leerzeilen := Leerzeilen + 1;
            
         else
            YTextposition := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => AnzuzeigenderText (TextSchleifenwert)),
                                                                                               TextpositionExtern       => (TextpositionExtern.x, YTextposition),
                                                                                               MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                               TextAccessExtern         => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert));
         end if;
         
      end loop TextSchleife;
      
      YTextposition := TextberechnungenHoeheGrafik.Leerzeilen (LeerzeilenExtern => Leerzeilen,
                                                               PositionExtern   => YTextposition);
         
      YTextposition := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => YTextposition,
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      return YTextposition;
            
   end WichtigesInformationen;
   
   
   
   function Koordinaten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return TextKonstantenHTSEB.LeerUnboundedString;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellePosition) & " " & ZahlAlsStringEbeneVorhanden (ZahlExtern => KoordinatenExtern.Ebene) & ","
              & KoordinatenExtern.Senkrechte'Wide_Wide_Image & "," & KoordinatenExtern.Waagerechte'Wide_Wide_Image;
      end case;
      
   end Koordinaten;
   
   
      
   function Rundenanzahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      AktuelleRundenanzahl := LeseAllgemeines.Rundenanzahl;
                  
      case
        LeseGrenzen.Speziesrundengrenze (SpeziesExtern => SpeziesExtern)
      is
         when ZahlenDatentypen.EigenesNatural'First =>
            Rundengrenze := LeseAllgemeines.Rundengrenze;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image & TextKonstantenHTSEB.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => LeseGrenzen.Speziesrundengrenze (SpeziesExtern => SpeziesExtern));
      end case;
      
      case
        Rundengrenze
      is
         when ZahlenDatentypen.EigenesNatural'First =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image & TextKonstantenHTSEB.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => Rundengrenze);
      end case;
      
   end Rundenanzahl;
   
   
   
   function Geld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            return TextKonstantenHTSEB.LeerUnboundedString;
            
         when others =>
            Geldzuwachs := LeseWichtiges.GeldRundengewinn (SpeziesExtern => SpeziesExtern);
      end case;
      
      if
        Geldzuwachs = ProduktionKonstanten.LeerProduktion
      then
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern)'Wide_Wide_Image;
           
      elsif
        Geldzuwachs > ProduktionKonstanten.LeerProduktion
      then
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern)'Wide_Wide_Image & TextKonstantenHTSEB.StandardAbstand & "+"
           & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldRundengewinn (SpeziesExtern => SpeziesExtern));
         
      else
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern)'Wide_Wide_Image & TextKonstantenHTSEB.StandardAbstand
           & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldRundengewinn (SpeziesExtern => SpeziesExtern));
      end if;
      
   end Geld;
   
   
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      Forschungsprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        Forschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstantenHTSEB.UmbruchAbstand & Spieltexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            Forschungszeit := LeseWichtiges.VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
      end case;
      
      case
        Forschungszeit
      is
         when ProduktionDatentypen.Lagermenge'Last =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstantenHTSEB.UmbruchAbstand & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => Forschungsprojekt,
                                                                                                                                                                             SpeziesExtern => SpeziesExtern)
              & TextKonstantenHTSEB.UnendlichGeklammert;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstantenHTSEB.UmbruchAbstand & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => Forschungsprojekt,
                                                                                                                                                                             SpeziesExtern => SpeziesExtern)
              & " (" & ZahlAlsStringKostenLager (ZahlExtern => Forschungszeit) & ")";
      end case;
      
   end Forschung;

end WichtigesSeitenleisteGrafik;
