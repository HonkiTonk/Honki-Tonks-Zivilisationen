package HTGGrenztestsystem is
   pragma Pure;

   generic type GanzeZahl is range <>;
   
   function Strichrechnung
     (GrundwertExtern : in GanzeZahl;
      ZusatzwertExtern : in GanzeZahl)
      return GanzeZahl;

   generic type GanzeZahl is range <>;
   
   function StrichrechnungNatural
     (GrundwertExtern : in GanzeZahl;
      ZusatzwertExtern : in GanzeZahl)
      return GanzeZahl;

   generic type GanzeZahl is range <>;
   
   function StrichrechnungPositive
     (GrundwertExtern : in GanzeZahl;
      ZusatzwertExtern : in GanzeZahl)
      return GanzeZahl;

   generic type GanzeZahl is range <>;
   
   function Multiplikation
     (GrundwertExtern : in GanzeZahl;
      MultiplikatorExtern : in GanzeZahl)
      return GanzeZahl;
   
   generic type KommaZahl is digits <>;

   function Kommamultiplikation
     (GrundwertExtern : in KommaZahl;
      MultiplikatorExtern : in KommaZahl)
      return KommaZahl;
   
end HTGGrenztestsystem;
