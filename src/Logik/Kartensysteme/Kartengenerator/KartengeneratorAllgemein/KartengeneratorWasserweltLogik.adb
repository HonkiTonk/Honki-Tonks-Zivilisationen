with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with Zusatzgrundplatzierungssystem;
with MeldungssystemHTSEB;
with ZufallsgeneratorenHTSEB;

package body KartengeneratorWasserweltLogik is

   procedure KartengeneratorWasserwelt
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      BasisgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
      ZusatzgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
   end KartengeneratorWasserwelt;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte))
      is
         when KartengrundDatentypen.Küstengewässer_Enum =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => KartengrundDatentypen.Küstengrund_Enum);
      
            
         when KartengrundDatentypen.Wasser_Enum =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => KartengrundDatentypen.Meeresgrund_Enum);
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorWasserweltLogik.BasisgrundBestimmen: Weder Küstengewässer noch Wasser");
      end case;
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      Zahlenspeicher := 0;
      WelcherGrund := 0;
            
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
         
         GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
         if
           GezogeneZahl > ZusatzWahrscheinlichkeiten (ZufallszahlSchleifenwert)
           or
             GezogeneZahl = 0
         then
            null;
            
         elsif
           (GezogeneZahl = Zahlenspeicher
            and
              ZufallsgeneratorenHTSEB.Münzwurf = True)
           or
             GezogeneZahl > Zahlenspeicher
         then
            Zahlenspeicher := GezogeneZahl;
            WelcherGrund := ZufallszahlSchleifenwert;
            
         else
            null;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      Zusatzgrund := ZahlenNachZusatzgrund (WelcherGrund);
      
      case
        Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return;
            
         when others =>
            Zusatzgrund := ZusatzExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => Zusatzgrund);
      end case;
      
      case
        Zusatzgrund
      is
         when KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum'Range =>
            Zusatzgrundplatzierungssystem.Zusatzgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                  ZusatzgrundExtern => Zusatzgrund);
            
         when others =>
            null;
      end case;
      
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum | KartengrundDatentypen.Küstengrund_Enum =>
            return ZusatzberechnungMeeresgrund (KoordinatenExtern => KoordinatenExtern,
                                                GrundExtern       => GrundExtern);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Zusatzgrund_Korallen_Enum'Range =>
            return ZusatzberechnungKorallen (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Zusatzgrund_Unterwald_Enum'Range =>
            return ZusatzberechnungUnterwald (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
      end case;
      
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungMeeresgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMeeresgrund;
   
   
   
   function ZusatzberechnungKorallen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Korallen_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungKorallen;
   
   
   
   function ZusatzberechnungUnterwald
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Unterwald_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.Senkrechte (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungUnterwald;

end KartengeneratorWasserweltLogik;
