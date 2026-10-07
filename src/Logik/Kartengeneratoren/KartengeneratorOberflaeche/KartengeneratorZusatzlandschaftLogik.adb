with ZufallsgeneratorenHTSEB;

with LeseWeltkarte;

with Zusatzgrundplatzierungssystem;
with ZufallsgeneratorenKartenLogik;

package body KartengeneratorZusatzlandschaftLogik is
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
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
         when KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum =>
            return;
            
         when others =>
            Zusatzgrund := ZusatzExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => Zusatzgrund);
      end case;
                  
      case
        Zusatzgrund
      is
         when KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum'Range =>
            Zusatzgrundplatzierungssystem.Zusatzgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                  ZusatzgrundExtern => Zusatzgrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range =>
            return ZusatzberechnungWald (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum'Range =>
            return ZusatzberechnungDschungel (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum'Range =>
            return ZusatzberechnungSumpf (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => GrundExtern);
            
         when KartenzusatzgrundDatentypen.Riffe_Enum =>
            return ZusatzberechnungRiffe (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => GrundExtern);
      end case;
   
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund = KartenbasisgrundDatentypen.Wüste_Enum
        or
          Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
      then
         return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungWald;
   
   
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund = KartenbasisgrundDatentypen.Wüste_Enum
        or
          Basisgrund = KartenbasisgrundDatentypen.Tundra_Enum
        or
          Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
      then
         return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
            
   end ZusatzberechnungDschungel;
   
   
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund = KartenbasisgrundDatentypen.Wüste_Enum
        or
          Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
      then
         return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungSumpf;
   
   
   
   function ZusatzberechnungRiffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartenzusatzgrundDatentypen.Zusatzgrund_Enum
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte));
      
      if
        Basisgrund in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
      then
         return GrundExtern;
         
      else
         return KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum;
      end if;
      
   end ZusatzberechnungRiffe;

end KartengeneratorZusatzlandschaftLogik;
