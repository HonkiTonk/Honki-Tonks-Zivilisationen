with SchreibeWeltkarte;

with ZufallsgeneratorenKartenLogik;
with ZufallegeneratorenAllgemein;

package body KartengeneratorErdweltLogik is

   procedure KartengeneratorErdwelt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      BasisgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
      ZusatzgrundBestimmen (KoordinatenExtern => KoordinatenExtern);
      
   end KartengeneratorErdwelt;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      Basisgrund := KartengrundDatentypen.Leer_Basisgrund_Enum;
      Zahlenspeicher := 0;
      
      BasisgrundSchleife:
      loop
         ZufallszahlenSchleife:
         for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
            GezogeneZahl := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
            if
              GezogeneZahl > BasisWahrscheinlichkeiten (ZufallszahlSchleifenwert)
              or
                GezogeneZahl = 0
            then
               null;
            
            elsif
              (GezogeneZahl = Zahlenspeicher
               and
                 ZufallegeneratorenAllgemein.Münzwurf = True)
              or
                GezogeneZahl > Zahlenspeicher
            then
               Zahlenspeicher := GezogeneZahl;
               Basisgrund := ZufallszahlSchleifenwert;
            
            else
               null;
            end if;
         
         end loop ZufallszahlenSchleife;
         
         case
           Basisgrund
         is
            when KartengrundDatentypen.Leer_Basisgrund_Enum =>
               null;
            
            when others =>
               exit BasisgrundSchleife;
         end case;
         
      end loop BasisgrundSchleife;
      
      Basisgrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => Basisgrund);
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                    GrundExtern       => Basisgrund);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      null;
      
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Erde_Enum =>
            return ZusatzberechnungErde (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Erdgestein_Enum =>
            return ZusatzberechnungErdgestein (KoordinatenExtern => KoordinatenExtern,
                                               GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Sand_Enum =>
            return ZusatzberechnungSand (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Gestein_Enum =>
            return ZusatzberechnungGestein (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
      end case;
      
   end BasisExtraberechnungen;
   
   
   
   function ZusatzberechnungErde
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungErde;
   
   
   
   function ZusatzberechnungErdgestein
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungErdgestein;
   
   
   
   function ZusatzberechnungSand
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungSand;
   
   
   
   function ZusatzberechnungGestein
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Unterfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGestein;

end KartengeneratorErdweltLogik;
