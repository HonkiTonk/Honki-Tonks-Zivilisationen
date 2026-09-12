with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KartenkoordinatenberechnungssystemLogik;
with ForschungstestsLogik;

-- Um da UND und ODER ein die Anforderungen zu bekommen müsste man hier alles noch einmal deutlich überarbeiten. äöü
package body GebaeudeanforderungenLogik is
   
   function AnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
   is begin
            
      if
        True = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                  WelchesGebäudeExtern     => IDExtern)
      then
         return False;
            
      elsif
        False = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                           TechnologieExtern => LeseGebaeudeDatenbank.Anforderungen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                     IDExtern      => IDExtern))
      then
         return False;
            
      elsif
        True = LeseGebaeudeDatenbank.FalscheEbene (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                   IDExtern      => IDExtern,
                                                   EbeneExtern   => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).Ebene)
      then
         return False;
         
      elsif
        False = NotwendigeGebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                             GebäudeIDExtern          => IDExtern)
      then
         return False;
         
      else
         UmgebungDurchgehen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         
         return NotwendigeUmgebung (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                    GebäudeIDExtern => IDExtern);
      end if;
      
   end AnforderungenErfüllt;
   
   
   
   function NotwendigeGebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         if
           False = LeseGebaeudeDatenbank.GebäudeBenötigt (SpeziesExtern        => StadtSpeziesNummerExtern.Spezies,
                                                            IDExtern             => GebäudeIDExtern,
                                                            WelchesGebäudeExtern => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           True = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     WelchesGebäudeExtern     => GebäudeSchleifenwert)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop GebäudeSchleife;
   
      return True;
      
   end NotwendigeGebäudeVorhanden;
   
   
   
   procedure UmgebungDurchgehen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      Umgebung := (others => (others => LeerUmgebung));
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Stadtumgebung := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Stadtumgebung.Senkrechte .. Stadtumgebung.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Stadtumgebung.Waagerechte .. Stadtumgebung.Waagerechte loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                        
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               KoordinatenExtern        => KartenWert)
            then
               null;
               
            else
               Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert);
               Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KartenWert);
               Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => KartenWert);
               Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => KartenWert);
               Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KartenWert);
               Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Weg := LeseWeltkarte.Weg (KoordinatenExtern => KartenWert);
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end UmgebungDurchgehen;
   
   
   
   -- Man könnte die Grundschleifen auch noch auf Basis der notwendigen Ebenen einschränken. äöü
   function NotwendigeUmgebung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GebäudeIDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
   is begin
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in KartenbasisgrundDatentypen.Basisgrund_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.BasisgrundBenötigt (SpeziesExtern => SpeziesExtern,
                                                              IDExtern      => GebäudeIDExtern,
                                                              GrundExtern   => BasisgrundSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => BasisgrundSchleifenwert,
                                     ZusatzgrundExtern  => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenwegeDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop BasisgrundSchleife;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in KartenzusatzgrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.ZusatzgrundBenötigt (SpeziesExtern => SpeziesExtern,
                                                               IDExtern      => GebäudeIDExtern,
                                                               GrundExtern   => ZusatzgrundSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => ZusatzgrundSchleifenwert,
                                     FlussExtern        => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenwegeDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop ZusatzgrundSchleife;
      
      FlussSchleife:
      for FlussSchleifenwert in KartenfluesseDatentypen.Fluss_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.FlussBenötigt (SpeziesExtern  => SpeziesExtern,
                                                         IDExtern       => GebäudeIDExtern,
                                                         FlussartExtern => FlussSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => FlussSchleifenwert,
                                     RessourceExtern    => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenwegeDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop FlussSchleife;
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in KartenressourcenDatentypen.Ressourcen_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.RessourceBenötigt (SpeziesExtern   => SpeziesExtern,
                                                             IDExtern        => GebäudeIDExtern,
                                                             RessourceExtern => RessourcenSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => RessourcenSchleifenwert,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenwegeDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop RessourcenSchleife;
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.VerbesserungBenötigt (SpeziesExtern      => SpeziesExtern,
                                                                IDExtern           => GebäudeIDExtern,
                                                                VerbesserungExtern => VerbesserungenSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => VerbesserungenSchleifenwert,
                                     WegExtern          => KartenwegeDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop VerbesserungenSchleife;
      
      WegeSchleife:
      for WegeSchleifenwert in KartenwegeDatentypen.Weg_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.WegBenötigt (SpeziesExtern => SpeziesExtern,
                                                       IDExtern      => GebäudeIDExtern,
                                                       WegExtern     => WegeSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => WegeSchleifenwert)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop WegeSchleife;
     
      return True;
   
   end NotwendigeUmgebung;
   


   function UmgebungVorhanden
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Enum;
      ZusatzgrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      FlussExtern : in KartenfluesseDatentypen.Fluss_Enum;
      RessourceExtern : in KartenressourcenDatentypen.Ressourcen_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      WegExtern : in KartenwegeDatentypen.Weg_Enum)
      return Boolean
   is begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in UmgebungArray'Range (1) loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in UmgebungArray'Range (2) loop
            
            if
              BasisgrundExtern /= KartenbasisgrundDatentypen.Leer_Basisgrund_Enum
              and then
                Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Basisgrund = BasisgrundExtern
            then
               return True;
               
            elsif
              ZusatzgrundExtern /= KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum
              and then
                Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Zusatzgrund = ZusatzgrundExtern
            then
               return True;
               
            elsif
              FlussExtern /= KartenfluesseDatentypen.Leer_Fluss_Enum
              and then
                Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Fluss = FlussExtern
            then
               return True;
               
            elsif
              RessourceExtern /= KartenressourcenDatentypen.Leer_Ressource_Enum
              and then
                Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Ressource = RessourceExtern
            then
               return True;
               
            elsif
              VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
              and then
                Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Verbesserung = VerbesserungExtern
            then
               return True;
               
            elsif
              WegExtern /= KartenwegeDatentypen.Leer_Weg_Enum
              and then
                Umgebung (SenkrechteSchleifenwert, WaagerechteSchleifenwert).Weg = WegExtern
            then
               return True;
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return False;
      
   end UmgebungVorhanden;
     
end GebaeudeanforderungenLogik;
