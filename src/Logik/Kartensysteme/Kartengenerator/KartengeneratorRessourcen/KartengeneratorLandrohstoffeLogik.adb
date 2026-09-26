with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with UmwandlungenRecords;

-- Eventuell kann man die ganzen Generatoren in einen schieben. äöü
-- Flüsse werden nicht berücksichtigt, wie bekomme ich die denn da noch rein? äöü
package body KartengeneratorLandrohstoffeLogik is

   procedure Landrohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      -- Die beiden Generatoren in einen Zusammenfassen. äöü
      -- Sollte leicht möglich sein mit einer einzelnen Boolean abfrage. äöü
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
      VorhandenerFluss := LeseWeltkarte.Fluss (KoordinatenExtern => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern));
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         GenerierungSchleife:
         loop
      
            Rohstoff := ZufallsgeneratorenKartenLogik.KartengeneratorRohstoffe;
            
            if
              BasisgrundRohstoffe (VorhandenerGrund.Basisgrund, Rohstoff) = False
            then
               null;
              
            elsif
              ZusatzgrundRohstoffe (VorhandenerGrund.Zusatzgrund, Rohstoff) = False
            then
               null;
               
            else
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
            end if;
            
            case
              FlussRohstoffe (VorhandenerFluss, Rohstoff)
            is
               when True =>
                  SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                               RohstoffnummerExtern => RohstoffeSchleifenwert,
                                               RohstoffExtern       => Rohstoff);
                  
                  exit GenerierungSchleife;
                  
               when False =>
                  null;
            end case;
                    
         end loop GenerierungSchleife;
      end loop RohstoffeSchleife;
      
   end RohstoffMehrfach;
   
   
   
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
              False = RohstoffeVergleichen (KoordinatenExtern => KoordinatenExtern,
                                            RohstoffExtern    => Rohstoff)
            then
               null;
            
            elsif
              BasisgrundRohstoffe (VorhandenerGrund.Basisgrund, Rohstoff) = False
            then
               null;
              
            elsif
              ZusatzgrundRohstoffe (VorhandenerGrund.Zusatzgrund, Rohstoff) = False
            then
               null;
               
            else
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
                  
               exit GenerierungSchleife;
            end if;
            
            case
              FlussRohstoffe (VorhandenerFluss, Rohstoff)
            is
               when True =>
                  SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => UmwandlungenRecords.KartenfeldVorhandenNatural (KoordinatenExtern => KoordinatenExtern),
                                               RohstoffnummerExtern => RohstoffeSchleifenwert,
                                               RohstoffExtern       => Rohstoff);
                  
                  exit GenerierungSchleife;
                  
               when False =>
                  null;
            end case;
            
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
