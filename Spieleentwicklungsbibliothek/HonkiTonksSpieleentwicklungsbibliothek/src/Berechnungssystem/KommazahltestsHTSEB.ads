package KommazahltestsHTSEB is
   pragma Pure;
   
   generic type Kommazahl is digits <>;
   
   function Strichrechnung
     (GrundwertExtern : in Kommazahl;
      ZusatzwertExtern : in Kommazahl)
      return Kommazahl;

   generic type Kommazahl is digits <>;
   
   function StrichrechnungNatural
     (GrundwertExtern : in Kommazahl;
      ZusatzwertExtern : in Kommazahl)
      return Kommazahl;

   generic type Kommazahl is digits <>;
   
   function StrichrechnungPositive
     (GrundwertExtern : in Kommazahl;
      ZusatzwertExtern : in Kommazahl)
      return Kommazahl;

   generic type Kommazahl is digits <>;

   function Multiplikation
     (GrundwertExtern : in Kommazahl;
      MultiplikatorExtern : in Kommazahl)
      return Kommazahl;

end KommazahltestsHTSEB;
