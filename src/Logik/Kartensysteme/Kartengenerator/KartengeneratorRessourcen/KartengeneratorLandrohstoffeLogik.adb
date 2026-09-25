with MeldungssystemHTSEB;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with UmwandlungenRecords;

-- Eventuell kann man die ganzen Generatoren in einen schieben. äöü
-- Möchte ich Ebenenübergreifende Berechnungen vornehmen muss ich die Ressourcen eh nacheinandern und nicht gleichzeitig generieren. äöü
-- Einfach Ebenenunabhängig bleiben oder das alles noch einmal anpassen? äöü
package body KartengeneratorLandrohstoffeLogik is

   procedure Landrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      case
        KartengeneratorVariablenLogik.RohstoffMehrfachLesen
      is
         when True =>
            RohstoffMehrfach (KoordinatenExtern => KoordinatenExtern);
            
         when False =>
            RohstoffEinmal (KoordinatenExtern => KoordinatenExtern);
      end case;
      
   end Landrohstoffe;
   
   
   
   procedure RohstoffMehrfach
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      VorhandenerGrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern));
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         GenerierungSchleife:
         loop
      
            Rohstoff := ZufallsgeneratorenKartenLogik.KartengeneratorRohstoffe;
            
            if
              False = Basisgrund (BasisgrundExtern => VorhandenerGrund.Basisgrund,
                                  RohstoffExtern   => Rohstoff)
            then
               null;
              
            elsif
              False = Zusatzgrund (ZusatzgrundExtern => VorhandenerGrund.Zusatzgrund,
                                   RohstoffExtern    => Rohstoff)
            then
               null;
               
            else
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
            end if;
            
         end loop GenerierungSchleife;
      end loop RohstoffeSchleife;
      
   end RohstoffMehrfach;
   
   
   
   function Basisgrund
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean
   is
      use type KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum;
      use type KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum;
   begin
      
      case
        BasisgrundExtern
      is
         when KartenbasisgrundDatentypen.Eis_Enum =>
            if
              RohstoffExtern = KartenrohstoffeDatentypen.Algen_Enum
              or
                RohstoffExtern = KartenrohstoffeDatentypen.Pilze_Enum
            then
               null;
               
            elsif
              RohstoffExtern = KartenrohstoffeDatentypen.Pinguine_Enum
              or
                RohstoffExtern = KartenrohstoffeDatentypen.Robben_Enum
                or
                  RohstoffExtern = KartenrohstoffeDatentypen.Krebse_Enum
                  or
                    RohstoffExtern = KartenrohstoffeDatentypen.Vögel_Enum
                    or
                      RohstoffExtern = KartenrohstoffeDatentypen.Wildtiere_Enum
            then
               null;
               
            elsif
              RohstoffExtern in KartenrohstoffeDatentypen.Rohstoffe_Mineralien_Oberbegriffe_Enum'Range
              or
                RohstoffExtern in KartenrohstoffeDatentypen.Rohstoffe_Eis_Enum'Range
            then
               null;
               
            else
               return False;
            end if;
            
         when KartenbasisgrundDatentypen.Basisgrund_Flachland_Enum'Range =>
            null;
            
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range =>
            null;
            
         when KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range =>
            null;
            
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            null;
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            null;
                        
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorLandrohstoffeLogik.Basisgrund: Falscher Basisgrund: " & BasisgrundExtern'Wide_Wide_Image);
      end case;
              
      return True;
      
   end Basisgrund;
   
   
   
   function Zusatzgrund
     (ZusatzgrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean
   is
      --  use type KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   begin
      
      case
        ZusatzgrundExtern
      is
         when KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum =>
            if
              RohstoffExtern not in KartenrohstoffeDatentypen.Rohstoffe_Pflanzen_Holz_Enum
            then
               null;
               
            else
               return False;
            end if;
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Wald_Enum'Range =>
            null;
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Dschungel_Enum'Range =>
            null;
            
         when KartenzusatzgrundDatentypen.Zusatzgrund_Sumpf_Enum'Range =>
            if
              RohstoffExtern not in KartenrohstoffeDatentypen.Rohstoffe_Pflanzen_Holz_Enum
            then
               null;
               
            else
               return False;
            end if;
            
         when others =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "KartengeneratorLandrohstoffeLogik.Zusatzgrund: Falscher Zusatzgrund: " & ZusatzgrundExtern'Wide_Wide_Image);
      end case;
              
      return True;
      
   end Zusatzgrund;
   
   
   
   procedure RohstoffEinmal
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      VorhandenerGrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern));
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         GenerierungSchleife:
         loop
      
            Rohstoff := ZufallsgeneratorenKartenLogik.KartengeneratorRohstoffe;
            
            if
              False =RohstoffeVergleichen (KoordinatenExtern => KoordinatenExtern,
                                           RohstoffExtern    => Rohstoff)
            then
               null;
            
            elsif
              False = Basisgrund (BasisgrundExtern => VorhandenerGrund.Basisgrund,
                                  RohstoffExtern   => Rohstoff)
            then
               null;
              
            elsif
              False = Zusatzgrund (ZusatzgrundExtern => VorhandenerGrund.Zusatzgrund,
                                   RohstoffExtern    => Rohstoff)
            then
               null;
               
            else
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
            end if;
            
         end loop GenerierungSchleife;
      end loop RohstoffeSchleife;
      
   end RohstoffEinmal;
   
   
   
   function RohstoffeVergleichen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      RohstoffExtern : in KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum)
      return Boolean
   is
      use type KartenrohstoffeDatentypen.Rohstoffe_Enum;
   begin
      
      VergleichenSchleife:
      for VergleichenSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
                  
         if
           RohstoffExtern = LeseWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                                     RohstoffnummerExtern => VergleichenSchleifenwert)
         then
            return False;
            
         else
            null;
         end if;
               
      end loop VergleichenSchleife;
      
      return True;
      
   end RohstoffeVergleichen;

end KartengeneratorLandrohstoffeLogik;
