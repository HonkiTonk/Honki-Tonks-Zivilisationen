with KartenKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with KartenkoordinatenberechnungssystemLogik;
with ForschungstestsLogik;

-- Um da UND und ODER ein die Anforderungen zu bekommen müsste man hier alles noch einmal deutlich überarbeiten. äöü
package body GebaeudeanforderungenLogik is
   
   -- Sollte ein Gebäude für eine Spezies nicht existieren dann einfach die Forschugnsanforderungen auf -1 setzen.
   function AnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
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
                                                   EbeneExtern   => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern).EAchse)
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
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
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
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Umgebung := (others => (others => LeerUmgebung));
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Umgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebungsgröße .. Umgebungsgröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebungsgröße .. Umgebungsgröße loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                        
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                               KoordinatenExtern        => KartenWert)
            then
               null;
               
            else
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert);
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KartenWert);
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => KartenWert);
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => KartenWert);
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => KartenWert);
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Weg := LeseWeltkarte.Weg (KoordinatenExtern => KartenWert);
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end UmgebungDurchgehen;
   
   
   
   -- Man könnte die Grundschleifen auch noch auf Basis der notwendigen Ebenen einschränken. äöü
   function NotwendigeUmgebung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
   is begin
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.BasisgrundBenötigt (SpeziesExtern => SpeziesExtern,
                                                              IDExtern      => GebäudeIDExtern,
                                                              GrundExtern   => BasisgrundSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => BasisgrundSchleifenwert,
                                     ZusatzgrundExtern  => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenextraDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenextraDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenverbesserungDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop BasisgrundSchleife;
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.ZusatzgrundBenötigt (SpeziesExtern => SpeziesExtern,
                                                               IDExtern      => GebäudeIDExtern,
                                                               GrundExtern   => ZusatzgrundSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => ZusatzgrundSchleifenwert,
                                     FlussExtern        => KartenextraDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenextraDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenverbesserungDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop ZusatzgrundSchleife;
      
      FlussSchleife:
      for FlussSchleifenwert in KartenextraDatentypen.Fluss_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.FlussBenötigt (SpeziesExtern  => SpeziesExtern,
                                                         IDExtern       => GebäudeIDExtern,
                                                         FlussartExtern => FlussSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => FlussSchleifenwert,
                                     RessourceExtern    => KartenextraDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenverbesserungDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop FlussSchleife;
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.RessourceBenötigt (SpeziesExtern   => SpeziesExtern,
                                                             IDExtern        => GebäudeIDExtern,
                                                             RessourceExtern => RessourcenSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenextraDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => RessourcenSchleifenwert,
                                     VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                     WegExtern          => KartenverbesserungDatentypen.Leer_Weg_Enum)
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
           True = UmgebungVorhanden (BasisgrundExtern   => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenextraDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenextraDatentypen.Leer_Ressource_Enum,
                                     VerbesserungExtern => VerbesserungenSchleifenwert,
                                     WegExtern          => KartenverbesserungDatentypen.Leer_Weg_Enum)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop VerbesserungenSchleife;
      
      WegeSchleife:
      for WegeSchleifenwert in KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range loop
         
         if
           False = LeseGebaeudeDatenbank.WegBenötigt (SpeziesExtern => SpeziesExtern,
                                                       IDExtern      => GebäudeIDExtern,
                                                       WegExtern     => WegeSchleifenwert)
         then
            null;
            
         elsif
           True = UmgebungVorhanden (BasisgrundExtern   => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                     ZusatzgrundExtern  => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                     FlussExtern        => KartenextraDatentypen.Leer_Fluss_Enum,
                                     RessourceExtern    => KartenextraDatentypen.Leer_Ressource_Enum,
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
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type KartengrundDatentypen.Zusatzgrund_Enum;
      use type KartenextraDatentypen.Fluss_Enum;
      use type KartenextraDatentypen.Ressourcen_Enum;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type KartenverbesserungDatentypen.Weg_Enum;
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in UmgebungArray'Range (1) loop
         XAchseSchleife:
         for XAchseSchleifenwert in UmgebungArray'Range (2) loop
            
            if
              BasisgrundExtern /= KartengrundDatentypen.Leer_Basisgrund_Enum
              and then
                Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Basisgrund = BasisgrundExtern
            then
               return True;
               
            elsif
              ZusatzgrundExtern /= KartengrundDatentypen.Leer_Zusatzgrund_Enum
              and then
                Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Zusatzgrund = ZusatzgrundExtern
            then
               return True;
               
            elsif
              FlussExtern /= KartenextraDatentypen.Leer_Fluss_Enum
              and then
                Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Fluss = FlussExtern
            then
               return True;
               
            elsif
              RessourceExtern /= KartenextraDatentypen.Leer_Ressource_Enum
              and then
                Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Ressource = RessourceExtern
            then
               return True;
               
            elsif
              VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
              and then
                Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Verbesserung = VerbesserungExtern
            then
               return True;
               
            elsif
              WegExtern /= KartenverbesserungDatentypen.Leer_Weg_Enum
              and then
                Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Weg = WegExtern
            then
               return True;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end UmgebungVorhanden;
     
end GebaeudeanforderungenLogik;
