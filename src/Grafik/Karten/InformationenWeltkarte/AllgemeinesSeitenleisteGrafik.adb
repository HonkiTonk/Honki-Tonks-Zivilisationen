with TextKonstantenHTSEB;

with TextKonstanten;

with LeseWeltkarte;
with LeseZeiger;

with TextberechnungenHoeheGrafik;
with AufgabenbeschreibungenGrafik;
with KartenbeschreibungenGrafik;
with TextaccessverwaltungssystemErweitertGrafik;

package body AllgemeinesSeitenleisteGrafik is

   function AllgemeineInformationen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
        
      YTextposition := TextpositionExtern.y;
      
      case
        SpeziesExtern
      is
         when SpeziesKonstanten.LeerSpezies =>
            Leerzeilen := AnzuzeigenderText'Last;
            
         when others =>
            Leerzeilen := 0;
            AktuelleKoordinaten := LeseZeiger.KoordinatenAktuell (SpeziesExtern => SpeziesExtern);
            
            AnzuzeigenderText (1) := Gesamtgrund (GesamtgrundExtern => LeseWeltkarte.Gesamtgrund (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (2) := Ressource (RessourceExtern => LeseWeltkarte.Ressource (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (3) := Verbesserung (VerbesserungExtern => LeseWeltkarte.Verbesserung (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (4) := Weg (WegExtern => LeseWeltkarte.Weg (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (5) := Fluss (FlussExtern => LeseWeltkarte.Fluss (KoordinatenExtern => AktuelleKoordinaten));
            AnzuzeigenderText (6) := Feldeffekte (KoordinatenExtern => AktuelleKoordinaten);
      
            TextSchleife:
            for TextSchleifenwert in TextaccessVariablen.KarteAllgemeinesAccess'Range loop
         
               if
                 AnzuzeigenderText (TextSchleifenwert) = TextKonstantenHTSEB.LeerUnboundedString
               then
                  Leerzeilen := Leerzeilen + 1;
            
               else
                  YTextposition := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenZeichnen (TextExtern               => To_Wide_Wide_String (Source => AnzuzeigenderText (TextSchleifenwert)),
                                                                                                     TextpositionExtern       => (TextpositionExtern.x, YTextposition),
                                                                                                     MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                     TextAccessExtern         => TextaccessVariablen.KarteAllgemeinesAccess (TextSchleifenwert));
               end if;
         
            end loop TextSchleife;
      end case;
      
      YTextposition := TextberechnungenHoeheGrafik.Leerzeilen (LeerzeilenExtern => Leerzeilen,
                                                               PositionExtern   => YTextposition);
         
      YTextposition := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => YTextposition,
                                                                     ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      return YTextposition;

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
            return KartenbeschreibungenGrafik.KurzbeschreibungBasisgrund (KartenGrundExtern => GesamtgrundExtern.Basisgrund) & TextKonstanten.Trennzeichen
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
            return TextKonstantenHTSEB.LeerUnboundedString;
            
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
            return TextKonstantenHTSEB.LeerUnboundedString;
            
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
            return TextKonstantenHTSEB.LeerUnboundedString;
            
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
            return TextKonstantenHTSEB.LeerUnboundedString;
            
         when others =>
            return KartenbeschreibungenGrafik.KurzbeschreibungFluss (KartenFlussExtern => FlussExtern);
      end case;
      
   end Fluss;
   
   
   
   function Feldeffekte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Zwischenspeicher := TextKonstantenHTSEB.LeerUnboundedString;
      
      FeldeffekteSchleife:
      for FeldeffektSchleifenwert in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range loop
      
         if
           False = LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                         WelcherEffektExtern => FeldeffektSchleifenwert)
         then
            null;
            
         elsif
           Zwischenspeicher = TextKonstantenHTSEB.LeerUnboundedString
         then
            Zwischenspeicher := KartenbeschreibungenGrafik.KurzbeschreibungFeldeffekte (FeldeffekteExtern => FeldeffektSchleifenwert);
                  
         else
            Zwischenspeicher := Zwischenspeicher & TextKonstanten.Trennzeichen & KartenbeschreibungenGrafik.KurzbeschreibungFeldeffekte (FeldeffekteExtern => FeldeffektSchleifenwert);
         end if;
         
      end loop FeldeffekteSchleife;
      
      return Zwischenspeicher;
      
   end Feldeffekte;

end AllgemeinesSeitenleisteGrafik;
