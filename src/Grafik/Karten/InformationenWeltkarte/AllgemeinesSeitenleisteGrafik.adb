with Spieltexte;
with TextnummernKonstanten;
with TextKonstanten;

with LeseWeltkarte;
with LeseCursor;

with TextberechnungenHoeheGrafik;
with AufgabenbeschreibungenGrafik;
with KartenbeschreibungenGrafik;
with TextaccessverwaltungssystemErweitertGrafik;

package body AllgemeinesSeitenleisteGrafik is

   function AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      LeerzeilenExtern : in Natural;
      MaximaleTextbreiteExtern : in Float)
      return GrafikRecords.YTextpositionLeerzeilenRecord
   is begin
        
      YTextposition := TextpositionExtern.y;
      Leerzeilen := LeerzeilenExtern;
      
      case
        SpeziesExtern
      is
         when SpeziesKonstanten.LeerSpezies =>
            AnzuzeigenderText := (others => TextKonstanten.LeerUnboundedString);
            
         when others =>
            AktuelleKoordinaten := LeseCursor.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
            
            AnzuzeigenderText (1) := Gesamtgrund (GesamtgrundExtern => LeseWeltkarte.Gesamtgrund (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (2) := Ressource (RessourceExtern => LeseWeltkarte.Ressource (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (3) := Verbesserung (VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (4) := Weg (WegExtern => LeseWeltkarte.Weg (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (5) := Fluss (FlussExtern => LeseWeltkarte.Fluss (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (6) := Feldeffekte (KoordinatenExtern => AktuelleKoordinaten);
      end case;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
         if
           AnzuzeigenderText (TextSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Leerzeilen := Leerzeilen + 1;
            
         else
            YTextposition := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnung (TextExtern               => To_Wide_Wide_String (Source => AnzuzeigenderText (TextSchleifenwert)),
                                                                                                TextpositionExtern       => (TextpositionExtern.x, YTextposition),
                                                                                                MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                TextAccessExtern         => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert));
         end if;
         
      end loop TextSchleife;
         
      YTextposition := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => YTextposition,
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      return (YTextposition, Leerzeilen);

   end AllgemeineInformationen;
   
   
   
   function Gesamtgrund
     (GesamtgrundExtern : in KartenRecords.KartengrundRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        GesamtgrundExtern.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return KartenbeschreibungenGrafik.KurzbeschreibungBasisgrund (KartenGrundExtern => GesamtgrundExtern.Basisgrund);
         
         when others =>
            return KartenbeschreibungenGrafik.KurzbeschreibungBasisgrund (KartenGrundExtern => GesamtgrundExtern.Basisgrund) & " " &  To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugMit)) & " "
              & KartenbeschreibungenGrafik.KurzbeschreibungZusatzgrund (KartenGrundExtern => GesamtgrundExtern.Zusatzgrund);
      end case;
      
   end Gesamtgrund;
   
   
   
   function Ressource
     (RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return KartenbeschreibungenGrafik.KurzbeschreibungRessource (KartenRessourceExtern => RessourceExtern);
      end case;
      
   end Ressource;
   
   
   
   function Verbesserung
     (VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return AufgabenbeschreibungenGrafik.KurzbeschreibungVerbesserung (KartenVerbesserungExtern => VerbesserungExtern);
      end case;
      
   end Verbesserung;
   
   
   
   function Weg
     (WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return AufgabenbeschreibungenGrafik.KurzbeschreibungWeg (KartenWegExtern => WegExtern);
      end case;
      
   end Weg;
   
   
   
   function Fluss
     (FlussExtern : in KartenextraDatentypen.Fluss_Enum)
      return Unbounded_Wide_Wide_String
   is begin
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return KartenbeschreibungenGrafik.KurzbeschreibungFluss (KartenFlussExtern => FlussExtern);
      end case;
      
   end Fluss;
   
   
   
   function Feldeffekte
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Zwischenspeicher := TextKonstanten.LeerUnboundedString;
      
      FeldeffekteSchleife:
      for FeldeffektSchleifenwert in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range loop
      
         if
           False = LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                         WelcherEffektExtern => FeldeffektSchleifenwert)
         then
            null;
            
         elsif
           Zwischenspeicher = TextKonstanten.LeerUnboundedString
         then
            Zwischenspeicher := KartenbeschreibungenGrafik.KurzbeschreibungFeldeffekte (FeldeffekteExtern => FeldeffektSchleifenwert);
                  
         else
            Zwischenspeicher := Zwischenspeicher & TextKonstanten.Trennzeichen & KartenbeschreibungenGrafik.KurzbeschreibungFeldeffekte (FeldeffekteExtern => FeldeffektSchleifenwert);
         end if;
         
      end loop FeldeffekteSchleife;
      
      return Zwischenspeicher;
      
   end Feldeffekte;

end AllgemeinesSeitenleisteGrafik;
