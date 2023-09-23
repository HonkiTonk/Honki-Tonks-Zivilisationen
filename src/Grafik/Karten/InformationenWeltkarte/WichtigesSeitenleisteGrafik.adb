with Spieltexte;
with TextnummernKonstanten;
with TextKonstanten;
with ForschungKonstanten;
with GrafikKonstanten;
with ProduktionKonstanten;
with KartenKonstanten;

with LeseWichtiges;
with LeseGrenzen;
with LeseAllgemeines;

with ForschungsbeschreibungenGrafik;
with TextaccessverwaltungssystemGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;

package body WichtigesSeitenleisteGrafik is

   function WichtigesInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Sf.System.Vector3.sfVector3f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            FestzulegenderText (1) := TextKonstanten.LeerUnboundedString;
            
         when others =>
            FestzulegenderText (1) := Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellePosition) & " " & ZahlAlsStringEbeneVorhanden (ZahlExtern => KoordinatenExtern.EAchse) & ","
              & KoordinatenExtern.YAchse'Wide_Wide_Image & "," & KoordinatenExtern.XAchse'Wide_Wide_Image;
      end case;
      
      FestzulegenderText (2) := Rundenanzahl (SpeziesExtern => SpeziesExtern);
      
      FestzulegenderText (3) := Geld (SpeziesExtern => SpeziesExtern); 
      FestzulegenderText (4) := Forschung (SpeziesExtern => SpeziesExtern);
            
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteWichtigesAccess'Range loop
         
         TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                 TextExtern       => To_Wide_Wide_String (Source => FestzulegenderText (TextSchleifenwert)),
                                                                 PositionExtern   => Textposition);
                  
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.KarteWichtigesAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
      end loop TextSchleife;
         
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      return (Textposition.x, Textposition.y, Textbreite);
            
   end WichtigesInformationen;
   
   
   
   function Rundenanzahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      AktuelleRundenanzahl := LeseAllgemeines.Rundenanzahl;
                  
      case
        LeseGrenzen.Speziesrundengrenze (SpeziesExtern => SpeziesExtern)
      is
         when ZahlenDatentypen.EigenesNatural'First =>
            Rundengrenze := LeseAllgemeines.Rundengrenze;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image & TextKonstanten.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => LeseGrenzen.Speziesrundengrenze (SpeziesExtern => SpeziesExtern));
      end case;
      
      case
        Rundengrenze
      is
         when ZahlenDatentypen.EigenesNatural'First =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleRunde) & AktuelleRundenanzahl'Wide_Wide_Image & TextKonstanten.Trennzeichen
              & ZahlAlsStringPositive (ZahlExtern => Rundengrenze);
      end case;
      
   end Rundenanzahl;
   
   
   
   function Geld
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        SpeziesExtern
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Geldzuwachs := LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => SpeziesExtern);
      end case;
      
      if
        Geldzuwachs = ProduktionKonstanten.LeerProduktion
      then
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern)'Wide_Wide_Image;
           
      elsif
        Geldzuwachs > ProduktionKonstanten.LeerProduktion
      then
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand & "+"
           & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => SpeziesExtern));
         
      else
         return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleGeldmenge) & LeseWichtiges.Geldmenge (SpeziesExtern => SpeziesExtern)'Wide_Wide_Image & TextKonstanten.StandardAbstand
           & ZahlAlsStringKostenLager (ZahlExtern => LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => SpeziesExtern));
      end if;
      
   end Geld;
   
   
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      Forschungsprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        Forschungsprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstanten.UmbruchAbstand & Spieltexte.Zeug (TextnummernKonstanten.ZeugKeines);
            
         when others =>
            Forschungszeit := LeseWichtiges.VerbleibendeForschungszeit (SpeziesExtern => SpeziesExtern);
      end case;
      
      case
        Forschungszeit
      is
         when ProduktionDatentypen.Lagermenge'Last =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstanten.UmbruchAbstand & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => Forschungsprojekt,
                                                                                                                                                                             SpeziesExtern => SpeziesExtern)
              & TextKonstanten.UnendlichGeklammert;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuellesForschungsprojekt) & TextKonstanten.UmbruchAbstand & ForschungsbeschreibungenGrafik.Kurzbeschreibung (IDExtern    => Forschungsprojekt,
                                                                                                                                                                             SpeziesExtern => SpeziesExtern)
              & " (" & ZahlAlsStringKostenLager (ZahlExtern => Forschungszeit) & ")";
      end case;
      
   end Forschung;

end WichtigesSeitenleisteGrafik;
